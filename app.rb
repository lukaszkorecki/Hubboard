require 'boot'

user, token = YAML::load_file('data.yml')

gh = Github::Feed.new do
  Github.get_feed user, token
end

gh.parse

puts gh.entries.to_yaml
