module Guard
  class Dsl
    class Action
      def initialize guardfile, action
        @guardfile = guardfile
        @action    = action
      end

      def on_change
        on_change_in(@action)
      end

      def on_change_in *patterns
        @guardfile.on_change_in(*patterns){ @action }
      end
    end
  end
end
