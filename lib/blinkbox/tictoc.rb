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
      # Starts a timer with the given label. Will return the last value of the timer
      # if #tic had been called before.
      #
      # @param [Symbol] label The label to use.
      # @return [Time, nil] The Time #tic was called with this label previously
      def tic(label = :default)
        last_value = (@@timers ||= {})[label]
        @@timers[label] = Time.now.utc
        last_value
      end

      # Returns the number of milliseconds since tic (for the same label) was called.
      # Will return nil if tic has never been called.
      #
      # @param [Symbol] label The label to use.
      # @return [Float, nil] The number of milliseconds since the equivalent #tic was last called.
      def toc(label = :default)
        return nil if @@timers[label].nil?
        ((Time.now.utc - @@timers[label]) * 1000).to_f
      end

      # Resets the timer for a specific label, or all labels (if none are specified)
      #
      # @param [Array<Symbol>] labels The labels to reset
      # @return [nil]
      def tictoc_reset(labels = [])
        @@timers = {} if labels.empty?
        labels.each do |label|
          @@timers[label] = nil
        end
        nil
      end
    end
  end
end