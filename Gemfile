source "http://rubygems.org"

# Declare your gem's dependencies in common-content.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
group :assets do
  gem 'coffee-rails'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.
gem 'twitter-bootstrap-rails', :git => "https://github.com/seyhunak/twitter-bootstrap-rails.git"
group :assets do
  gem 'less'
  gem 'therubyrhino', :platform => :jruby
  gem 'therubyracer', :platform => :ruby
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
