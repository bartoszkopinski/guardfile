# Guardfile

Provides better DSL for Guardfiles

## Installation

Add this line to your application's Gemfile:

    gem 'guardfile'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guardfile

## Usage

Sample Guardfile:

```ruby
require 'guardfile'

with_shell do
  on_change_in('Gemfile') do
    `bundle install && touch tmp/restart.txt`
  end
end

with_spork(all_after_pass: false, all_on_start: false, bundler: false) do
  run(:rspec).on_change_in(
    'config/*.rb',
    'lib/*.rb',
    'Gemfile.lock',
    'spec/spec_helper.rb',
  )
end

with_rspec(rspec_env: { RAILS_ENV: 'test' }, wait: 60) do
  run('spec/*_spec.rb').on_change
  run('spec/lib/*_spec.rb').on_change_in('lib/*.rb')
  run('spec/views/*/*_spec.rb').on_change_in('app/views/*/*.haml')
  run('spec/controllers/*_controller_spec.rb').on_change_in('app/controllers/*_controller.rb')
  run('spec/controllers/').on_change_in('app/controllers/application_controller.rb')
  run('spec/').on_change_in(
    'spec/factories.rb',
    'spec/spec_helper.rb',
    'spec/support/*.rb',
    'config/*.rb',
  )
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
