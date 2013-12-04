module Guard
  class Dsl
    class Action
      def initialize guardfile, action
        @guardfile = guardfile
        @action    = action
      end

      def on_change *patterns
        @guardfile.on_change(*patterns){ @action }
      end
    end
  end
end
