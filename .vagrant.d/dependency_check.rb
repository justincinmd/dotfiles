#!/usr/bin/env ruby
require 'pathname'

# Verify berks-cookbooks is up-to-date.
class DependencyCheck
  def self.check
    DependencyCheck.new.check
  end

  def initialize
    @dir = Pathname.new(__FILE__).dirname
  end

  def check
    dependencies_mtime = last_modified_for('cookbooks/**/*', 'Berksfile')
    vendored_mtime = last_modified_for('berks-cookbooks/**/*')

    if vendored_mtime.nil? or dependencies_mtime > vendored_mtime
      puts "Vendored cookbooks need to be updated."
      puts "cd to `#{@dir}` and run `bundle exec berks vendor`"
      exit(1)
    end
  end

  def last_modified_for(*args)
    paths = args.map{|f| @dir.join(f)}
    return Dir[*paths].map{|f| File.mtime(f)}.sort.last
  end
end
DependencyCheck.check
