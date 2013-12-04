require_relative 'dsl/action'
require_relative 'dsl/change'

module Guard
  class Dsl
    def run action
      Action.new(self, action)
    end

    def on_change *patterns, &action
      return Change.new(self, patterns) unless block_given?
      patterns.each do |pattern|
        UI.info "Watching #{pattern}"
        watch(pattern_regexp(pattern)) do |match|
          build_action(action.call, match)
        end
      end
    end

    def method_missing method, options = {}, &action
      super unless method.to_s =~ /^with_(.+)$/
      guard($1, options) do
        rules = action.call
        next unless rules.is_a? Hash
        rules.each do |command, patterns|
          on_change(*Array(patterns)){ command }
        end
      end
    end

    private

    def build_action command, match
      case command
      when String
        command.gsub('*'){ match.slice!(1) }
      when Proc
        command.call
      else
        command
      end
    end

    def pattern_regexp pattern
      /^#{Regexp.escape(pattern).gsub('\\*', '(.*)')}$/i
    end
  end
end
