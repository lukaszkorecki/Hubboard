require 'rubygems'
namespace :osx do
  OSX_DEV_COMMAND = "arch -i386 /usr/bin/ruby -rubygems -C . app.rb"
  OSX_COMMAND = "arch -i386 /usr/bin/ruby -C . app.rb"
  desc "run the application on OSX (needs wx gem)"
  task :run_dev do
    STDOUT << `#{OSX_DEV_COMMAND}`
  end
  task :run do
    STDOUT << `#{OSX_COMMAND}`
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
    Dir["frames/*.xrc"].each do |file|
      `xrcise #{file} > #{file.sub(".xrc", ".rb").sub("frames/","views/")}`
    end
  end
end
namespace :app do
  desc "download and unpack all gems using bundler"
  task :package_gems do
    `bundle install vendor --without test --disable-shared-gems`
  end
  desc "regenrates xrc class loader from xrc file"
  task  :wx_generate do
    STDOUT << `xrcise views/hubboard_views.xrc > views/hubboard_views.rb`
  end
end
desc "run tests"
task :spec_details do
  STDOUT << `spec -c -fn spec`
end
task :spec do
  STDOUT << `spec spec`
end

task :default => [:spec]
