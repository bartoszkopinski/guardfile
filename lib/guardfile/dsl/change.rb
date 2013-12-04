module Guard
  class Dsl
    class Change
      def initialize guardfile, patterns
        @guardfile = guardfile
        @patterns  = patterns
      end

      def run action
        @guardfile.run(action).on_change_in(*@patterns)
      end
    end
  end
end
