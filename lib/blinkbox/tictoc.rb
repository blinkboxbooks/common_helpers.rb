module Blinkbox
  module CommonHelpers
    # Gives you two methods, `tic` and `toc`. Without arguments `toc` will give you the number of milliseconds
    # since you last called `tic`. Takes one argument, which can be used to have two timers running independently:
    #
    # @example: Basic use
    #   include Blinkbox::CommonHelpers::TicToc
    #   tic
    #   sleep 9
    #   p toc
    #   # => 9001
    #   # (It is over 9000 because time is an illusion, lunchtime doubly so)
    #
    # @example: Parallel use
    #   include Blinkbox::CommonHelpers::TicToc
    #   tic :a
    #   sleep 1
    #   tic :b
    #   sleep 1
    #   p toc :b
    #   # => 1000
    #   sleep 1
    #   p toc :a
    #   # => 3000
    module TicToc
      def tic(label = :default)
        last_value = (@@timers ||= {})[label]
        @@timers[label] = Time.now.utc
        last_value
      end

      def toc(label = :default)
        return nil if @@timers[label].nil?
        ((Time.now.utc - @@timers[label]) * 1000).to_f
      end
    end
  end
end