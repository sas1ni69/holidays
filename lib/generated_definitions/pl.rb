# encoding: utf-8
module Holidays
  # This file is generated by the Ruby Holidays gem.
  #
  # Definitions loaded: definitions/pl.yaml
  #
  # To use the definitions in this file, load it right after you load the
  # Holiday gem:
  #
  #   require 'holidays'
  #   require 'generated_definitions/pl'
  #
  # All the definitions are available at https://github.com/holidays/holidays
  module PL # :nodoc:
    def self.defined_regions
      [:pl]
    end

    def self.holidays_by_month
      {
              0 => [{:function => "easter(year)", :function_modifier => -52, :type => :informal, :name => "Tłusty Czwartek", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -47, :type => :informal, :name => "Ostatki", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -46, :type => :informal, :name => "Środa Popielcowa", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -7, :type => :informal, :name => "Niedziela Palmowa", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -3, :type => :informal, :name => "Wielki Czwartek", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -2, :type => :informal, :name => "Wielki Piątek", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => -1, :type => :informal, :name => "Wielka Sobota", :regions => [:pl]},
            {:function => "easter(year)", :name => "Niedziela Wielkanocna", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => 1, :name => "Poniedziałek Wielkanocny (Lany Poniedziałek)", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => 49, :name => "Zesłanie Ducha Świętego (Zielone Świątki)", :regions => [:pl]},
            {:function => "easter(year)", :function_modifier => 60, :name => "Uroczystość Najświętszego Ciała i Krwi Pańskiej (Boże Ciało)", :regions => [:pl]}],
      1 => [{:mday => 1, :name => "Nowy Rok", :regions => [:pl]},
            {:function => "pl_trzech_kroli(year)", :name => "Objawienie Pańskie (święto Trzech Króli)", :regions => [:pl]},
            {:function => "pl_trzech_kroli_informal(year)", :type => :informal, :name => "Objawienie Pańskie (święto Trzech Króli)", :regions => [:pl]},
            {:mday => 21, :type => :informal, :name => "Dzień Babci", :regions => [:pl]},
            {:mday => 22, :type => :informal, :name => "Dzień Dziadka", :regions => [:pl]}],
      2 => [{:mday => 2, :type => :informal, :name => "Ofiarowanie Pańskie (Matki Boskiej Gromnicznej)", :regions => [:pl]},
            {:mday => 14, :type => :informal, :name => "Dzień Zakochanych (Walentynki)", :regions => [:pl]}],
      3 => [{:mday => 8, :type => :informal, :name => "Dzień Kobiet", :regions => [:pl]},
            {:mday => 10, :type => :informal, :name => "Dzień Mężczyzn", :regions => [:pl]}],
      4 => [{:mday => 1, :type => :informal, :name => "Prima Aprilis", :regions => [:pl]},
            {:mday => 22, :type => :informal, :name => "Międzynarodowy Dzień Ziemi", :regions => [:pl]}],
      5 => [{:mday => 1, :name => "Święto Państwowe (Święto Pracy)", :regions => [:pl]},
            {:mday => 2, :type => :informal, :name => "Dzień Flagi Rzeczpospolitej Polskiej", :regions => [:pl]},
            {:mday => 3, :name => "Święto Narodowe Trzeciego Maja", :regions => [:pl]}],
      6 => [{:mday => 23, :type => :informal, :name => "Dzień Ojca", :regions => [:pl]}],
      8 => [{:mday => 15, :name => "Wniebowzięcie Najświętszej Maryi Panny", :regions => [:pl]},
            {:mday => 15, :name => "Święto Wojska Polskiego", :regions => [:pl]}],
      9 => [{:mday => 30, :type => :informal, :name => "Dzień Chłopaka", :regions => [:pl]}],
      10 => [{:mday => 14, :type => :informal, :name => "Dzień Nauczyciela (Dzień Edukacji Narodowej)", :regions => [:pl]}],
      11 => [{:mday => 1, :name => "Wszystkich Świętych", :regions => [:pl]},
            {:mday => 2, :type => :informal, :name => "Dzień Zaduszny", :regions => [:pl]},
            {:mday => 11, :name => "Narodowe Święto Niepodległości", :regions => [:pl]},
            {:mday => 29, :type => :informal, :name => "Andrzejki", :regions => [:pl]}],
      12 => [{:mday => 4, :type => :informal, :name => "Barbórka (Dzień Górnika, Naftowca i Gazownika)", :regions => [:pl]},
            {:mday => 6, :type => :informal, :name => "Mikołajki", :regions => [:pl]},
            {:mday => 24, :type => :informal, :name => "Wigilia Bożego Narodzenia", :regions => [:pl]},
            {:mday => 25, :name => "pierwszy dzień Bożego Narodzenia", :regions => [:pl]},
            {:mday => 26, :name => "drugi dzień Bożego Narodzenia", :regions => [:pl]},
            {:mday => 31, :type => :informal, :name => "Sylwester", :regions => [:pl]}]
      }
    end

    def self.custom_methods
      {
        "pl_trzech_kroli(year)" => Proc.new { |year|
year >= 2011 ? 6 : nil
},

"pl_trzech_kroli_informal(year)" => Proc.new { |year|
year < 2011 ? 6 : nil
},


      }
    end
  end
end
