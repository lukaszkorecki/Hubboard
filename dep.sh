echo Downloading wxruby
curl -C - -O http://rubyforge.org/frs/download.php/63386/wxruby-2.0.1-universal-darwin-9.gem

echo Deploying wxruby to vendor
gem install http://rubyforge.org/frs/download.php/63386/wxruby-2.0.1-universal-darwin-9.gem -i vendor

echo Running bundler
bundle install vendor --without test
