require 'rubygems'
require 'fileutils'
include FileUtils
namespace :osx do
  desc "get dependencies and put them into vendor/"
  task :get_dependencies do
    STDOUT << 'Installing gems via bundler'
    STDOUT << `bundle install vendor --without linux`
    STDOUT << 'Downloading wxruby'
    STDOUT << `curl -L -A Firefox  http://rubyforge.org/frs/download.php/63386/wxruby-2.0.1-universal-darwin-9.gem > wxruby-2.0.1.gem`
    STDOUT << 'Deploying wxruby to vendor'
    STDOUT << `gem install wxruby-2.0.1.gem -i vendor/ruby/1.8/gems`
    rm 'wxruby-2.0.1.gem'
  end

  desc "run application"
  task :run do
    STDOUT << `arch -i386 bin/Hubboard -C . app.rb`
  end

  desc "package using platypus"
  task :package do
    current_path = FileUtils.pwd
    cmd =[ '/usr/local/bin/platypus -B']
    cmd << "-a 'Hubboard'"
    cmd << "-i assets/icon_256.png"
    cmd << "-o 'None'"
    cmd << "-p '/usr/bin/env'"
    cmd << "-I 'com.coffeesounds.Hubboard'"
    cmd << "-f '#{current_path}/app.rb'"
    cmd << "-f '#{current_path}/assets'"
    cmd << "-f '#{current_path}/bin'"
    cmd << "-f '#{current_path}/controllers'"
    cmd << "-f '#{current_path}/lib'"
    cmd << "-f '#{current_path}/osx_run'"
    cmd << "-f '#{current_path}/vendor'"
    cmd << "-f '#{current_path}/views'"
    cmd << "-G 'bash'"
    cmd << "-c '#{current_path}/osx_run' 'Hubboard.app'"
    STDERR << `#{cmd.join(" ")}`
  end
end

namespace :linux do
  desc "runs  the app on linux using rubygems"
  task :run do
    `ruby -rubygems app.rb`
  end
end

namespace :wx do
  desc "generate all ruby classes from XRC files"
  task :generate do
    STDOUT << `xrcise views/hubboard_views.xrc > views/hubboard_views.rb`
  end
end

desc "run tests with detailed output"
task :spec_details do
  STDOUT << `spec -c -fn spec`
end

desc 'run test without details'
task :spec do
  STDOUT << `spec spec`
end

task :default => [:spec]
