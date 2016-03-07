require 'yaml'

module Holidays
  module Definition
    module Context
      class Generator
        def initialize(custom_method_parser, custom_method_source_decorator)
          @custom_method_parser = custom_method_parser
          @custom_method_source_decorator = custom_method_source_decorator
        end

        def parse_definition_files(files)
          raise ArgumentError, "Must have at least one file to parse" if files.nil? || files.empty?

          all_regions = []
          all_rules_by_month = {}
          all_custom_methods = {}
          all_tests = []

          files.flatten!

          files.each do |file|
            definition_file = YAML.load_file(file)

            regions, rules_by_month = parse_month_definitions(definition_file['months'])

            all_regions << regions.flatten

            all_rules_by_month.merge!(rules_by_month) { |month, existing, new|
              existing << new
              existing.flatten!
            }

            custom_methods = parse_method_definitions(definition_file['methods'])

            #FIXME This is a problem. We will have a 'global' list of methods. That's always bad. What effects will this have?
            # This is an existing problem (just so we are clear). An issue would be extremely rare because we are generally parsing
            # single files/custom files. But it IS possible that we would parse a bunch of things at the same time and step
            # on each other so we need a solution.
            all_custom_methods.merge!(custom_methods)

            all_tests << parse_test_definitions(definition_file['tests'])
          end

          all_regions.flatten!.uniq!

          [all_regions, all_rules_by_month, all_custom_methods, all_tests]
        end

        def generate_definition_source(module_name, files, regions, rules_by_month, custom_methods, tests)
          month_strings = generate_month_definition_strings(rules_by_month)

          # Build the custom methods string
          custom_method_string = ''
          custom_methods.each do |key, code|
            custom_method_string << custom_method_source_decorator.call(code) + ",\n\n"
          end

          module_src = generate_module_src(module_name, files, regions, month_strings, custom_method_string)
          test_src = generate_test_src(module_name, files, tests)

          return module_src, test_src || ''
        end

        private

        attr_reader :custom_method_parser, :custom_method_source_decorator

        def parse_month_definitions(month_definitions)
          regions = []
          rules_by_month = {}

          if month_definitions
            month_definitions.each do |month, definitions|
              rules_by_month[month] = [] unless rules_by_month[month]
              definitions.each do |definition|
                rule = {}

                definition.each do |key, val|
                  rule[key.to_sym] = val
                end

                rule[:regions] = rule[:regions].collect { |r| r.to_sym }

                regions << rule[:regions]

                exists = false
                rules_by_month[month].each do |ex|
                  if ex[:name] == rule[:name] and ex[:wday] == rule[:wday] and ex[:mday] == rule[:mday] and ex[:week] == rule[:week] and ex[:type] == rule[:type] and ex[:function] == rule[:function] and ex[:observed] == rule[:observed] and ex[:year_ranges] == rule[:year_ranges]
                    ex[:regions] << rule[:regions].flatten
                    exists = true
                  end
                end

                unless exists
                  rules_by_month[month] << rule
                end
              end
            end
          end

          [regions, rules_by_month]
        end

        def parse_method_definitions(methods)
          return {} if methods.nil? || methods.empty? #FIXME This is not necessary, the parser checks it as well.
          custom_method_parser.call(methods)
        end

        def parse_test_definitions(tests)
          test_strings = []

          if tests
            test_strings << tests
          end

          test_strings
        end

        def generate_month_definition_strings(rules_by_month)
          month_strings = []

          rules_by_month.each do |month, rules|
            month_string = "      #{month.to_s} => ["
            rule_strings = []
            rules.each do |rule|
              string = '{'
              if rule[:mday]
                string << ":mday => #{rule[:mday]}, "
              end

              if rule[:function]
                string << ":function => \"#{rule[:function].to_s}\", "

                if rule[:function_modifier]
                  string << ":function_modifier => #{rule[:function_modifier].to_s}, "
                end
              end

              # This is the 'else'. It is possible for mday AND function
              # to be set but this is the fallback. This whole area
              # needs to be reworked!
              if string == '{'
                string << ":wday => #{rule[:wday]}, :week => #{rule[:week]}, "
              end

              if rule[:year_ranges] && rule[:year_ranges].kind_of?(Array)
                year_string = " :year_ranges => ["
                len = rule[:year_ranges].length
                rule[:year_ranges].each_with_index do |year,index|
                  year_string << "{:#{year.keys.first} => #{year.values.first}}"
                  if len == index + 1
                    year_string << "],"
                  else
                    year_string << ","
                  end
                end
                string << year_string
              end

              if rule[:observed]
                string << ":observed => \"#{rule[:observed].to_s}\", "
              end

              if rule[:type]
                string << ":type => :#{rule[:type]}, "
              end

              # shouldn't allow the same region twice
              string << ":name => \"#{rule[:name]}\", :regions => [:" + rule[:regions].uniq.join(', :') + "]}"
              rule_strings << string
            end
            month_string << rule_strings.join(",\n            ") + "]"
            month_strings << month_string
          end

          return month_strings
        end

        def generate_module_src(module_name, files, regions, month_strings, custom_methods)
          module_src = ""

          module_src =<<-EOM
# encoding: utf-8
module Holidays
  # This file is generated by the Ruby Holidays gem.
  #
  # Definitions loaded: #{files.join(', ')}
  #
  # To use the definitions in this file, load it right after you load the
  # Holiday gem:
  #
  #   require 'holidays'
  #   require '#{DEFINITIONS_PATH}/#{module_name.to_s.downcase}'
  #
  # All the definitions are available at https://github.com/holidays/holidays
  module #{module_name.to_s.upcase} # :nodoc:
    def self.defined_regions
      [:#{regions.join(', :')}]
    end

    def self.holidays_by_month
      {
        #{month_strings.join(",\n")}
      }
    end

    def self.custom_methods
      {
        #{custom_methods}
      }
    end
  end
end
        EOM

          return module_src
        end

        def generate_test_src(module_name, files, tests)
          unless tests.empty?
            test_src = ""

            test_src =<<-EndOfTests
# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/../test_helper'

# This file is generated by the Ruby Holiday gem.
#
# Definitions loaded: #{files.join(', ')}
class #{module_name.to_s.capitalize}DefinitionTests < Test::Unit::TestCase  # :nodoc:

  def test_#{module_name.to_s.downcase}
#{tests.join("\n\n")}
  end
end
  EndOfTests
          end

          return test_src
        end
      end
    end
  end
end
