# Set $GEM_HOME in case Rubygems loads
require 'rbconfig'
gem_path = File.join("../../.bundle", RUBY_ENGINE, RbConfig::CONFIG["ruby_version"])
ENV['GEM_HOME'] = File.expand_path(gem_path, __FILE__)

if defined?(Gem)
  STDERR.puts "Running without Rubygems, but Rubygems is already loaded!"
else
  module Gem
    # ActiveRecord requires Gem::LoadError to load
    class LoadError < ::LoadError; end

    # BacktraceCleaner wants path and default_dir
    def self.path; []; end
    def self.default_dir
      @default_dir ||= File.expand_path("../../.bundle/#{RUBY_ENGINE}/#{RbConfig::CONFIG["ruby_version"]}", __FILE__)
    end

    # irb/locale.rb calls this if defined?(Gem)
    def self.try_activate(*); end
  end

  module Kernel
    # ActiveSupport requires Kernel.gem to load
    def gem(*); end
    # in Ruby 2.1.2, rdoc/task.rb requires rubygems itself :(
    alias_method :orig_require, :require
    def require(*args); args.first == "rubygems" || orig_require(*args); end
  end
end
