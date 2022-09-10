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
        _clone(hash1)
      end

      def slice(*keys)
        hash1 = hash.slice(*keys)
        _clone(hash1)
      end

      def to_h; hash end

      def without(*keys)
        slice(*(hash.keys - keys))
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
