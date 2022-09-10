# frozen_string_literal: true

require_relative 'map/api'
module L42
  class Map
    RestrictedNames = %i[
      empty? fetch merge slice to_h with_default without
    ].freeze

    include Api

    def with_default(default)
      @default = default
      _define_method_missing
      self
    end

    private
    attr_accessor :default, :hash

    def initialize(**kwds)
      @default = nil
      @hash    = kwds
      (kwds.keys - RestrictedNames).each(&_define_accessor_method)
    end

    def _define_accessor_method
      ->key do
        class << self; self end.module_eval do
          define_method key do
            hash[key]
          end
        end
      end
    end

    def _define_method_missing
      class << self; self end.module_eval do
        define_method :method_missing do |_name|
          default
        end
      end
    end

  end
end
# SPDX-License-Identifier: Apache-2.0
