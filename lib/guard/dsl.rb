module Guard
  class Dsl
    def method_missing(guard_name, options = {}, &block)
      guard(guard_name, options) do
        yield.each do |specs, files|
          Array(files).each do |f|
            ::Guard::UI.info "Watching #{f}"
            regexp = Regexp.escape(f)
            regexp.gsub!('\\*', '(.+)')

            watch(/^#{regexp}$/) do |m|
              case specs
              when String
                specs.gsub('*'){ m.slice!(1) }
              else
                specs
              end
            end
          end
        end
      end
    end
  end
end
