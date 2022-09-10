# frozen_string_literal: true

module L42
  class Map
    module EnumerableApi
      include Enumerable
      def each(&blk)
        hash.each(&blk)
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
