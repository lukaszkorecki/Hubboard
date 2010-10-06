require 'lib/github/feed'
require 'lib/github/user'
require 'yaml'
require 'simplehttp'
module Github
  API_URL = 'http://github.com/api/v2/yaml'
  FEED_URL = 'https://github.com/{username}.private.atom?token={token}'

  def self.http_get url
    SimpleHttp.get URI.parse url
  end
  def self.get_feed username, token
    t_url = FEED_URL.sub("{username}", username).sub("{token}", token)
    http_get t_url
  end
  def self.get_api path, auth=nil
    # TODO handle basic auth
    http_get API_URL+path
  end
end
