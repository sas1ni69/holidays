# encoding: utf-8
module Holidays
  # This file is generated by the Ruby Holidays gem.
  #
  # Definitions loaded: definitions/ecb_target.yaml
  #
  # To use the definitions in this file, load it right after you load the
  # Holiday gem:
  #
  #   require 'holidays'
  #   require 'generated_definitions/ecb_target'
  #
  # All the definitions are available at https://github.com/holidays/holidays
  module ECB_TARGET # :nodoc:
    def self.defined_regions
      [:ecb_target]
    end

    def self.holidays_by_month
      {
              0 => [{:function => "easter(year)", :function_modifier => -2, :name => "Good Friday", :regions => [:ecb_target]},
            {:function => "easter(year)", :function_modifier => 1, :name => "Easter Monday", :regions => [:ecb_target]}],
      1 => [{:mday => 1, :name => "New Year's Day", :regions => [:ecb_target]}],
      5 => [{:mday => 1, :name => "Labour Day", :regions => [:ecb_target]}],
      12 => [{:mday => 25, :name => "Christmas Day", :regions => [:ecb_target]},
            {:mday => 26, :name => "Christmas Holiday", :regions => [:ecb_target]}]
      }
    end

    def self.custom_methods
      {
        
      }
    end
  end
end
