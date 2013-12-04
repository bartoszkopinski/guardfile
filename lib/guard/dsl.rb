require 'guard/guardfile'
require 'guard/ui'

require 'guard/dsl/action'
require 'guard/dsl/change'

module Guard
  class Dsl
    def run action
      Action.new(self, action)
    end

    def on_change_in *patterns, &action
      return Change.new(self, patterns) unless block_given?

      patterns.each do |pattern|
        UI.info "Watching #{pattern}"
        watch(pattern_regexp(pattern)) do |match_data|
          UI.info "Change in: #{fill_with_matches(pattern, match_data)}"
          build_action(action.call, match_data)
        end
      end
    end

    def method_missing method, options = {}, &action
      super unless method.to_s =~ /^with_(.+)$/

      guard($1, options) do
        rules = action.call
        next unless rules.is_a? Hash
        rules.each do |command, patterns|
          on_change_in(*Array(patterns)){ command }
        end
      end
    end

    private

    def fill_with_matches string, match_data
      string.gsub(?*).each_with_index{ |_, i| match_data[i+1] }
    end

    def build_action command, match_data
      case command
      when String
        fill_with_matches(command, match_data)
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
