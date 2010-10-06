require 'boot'

gh = Github::Feed.new do
  u,t = Github.git_config
  Github.get_feed u,t
end

gh.parse

puts gh.entries.to_yaml
