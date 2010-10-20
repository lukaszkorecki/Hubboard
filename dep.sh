echo Downloading wxruby
curl -L -A Firefox  http://rubyforge.org/frs/download.php/63386/wxruby-2.0.1-universal-darwin-9.gem > wxruby-2.0.1.gem

echo Deploying wxruby to vendor
gem install wxruby-2.0.1.gem -i vendor/ruby/1.8/gems

echo Running bundler
bundle install vendor --without test
