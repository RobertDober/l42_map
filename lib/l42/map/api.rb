# frozen_string_literal: true

module L42
  class Map
    module Api
      def [](key)
        hash[key]
      end

      def empty?
        hash.empty?
      end

      def fetch(*args, &blk)
        hash.fetch(*args, &blk)
      end

      def merge(*args, &blk)
        hash1 = hash.merge(*args, &blk)
        self.class.new(**hash1).tap do |new_instance|
          new_instance.with_default(default) if default
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
