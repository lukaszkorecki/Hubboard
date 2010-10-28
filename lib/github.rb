require 'lib/github/feed'
require 'lib/github/user'

module Github

  # net operations
  API_URL = 'http://github.com/api/v2/yaml'
  FEED_URL = 'https://github.com/{username}.private.atom?token={token}'

  def self.http_get url
    begin
      res = SimpleHttp.get URI.parse url
    rescue => e
      res = false
    end
    res
  end
  def self.get_feed username, token
    t_url = FEED_URL.sub("{username}", username).sub("{token}", token)
    begin
      resp = http_get t_url
    rescue => e
      return false
    end
    resp
  end

  def self.get_api path, auth=nil
    http_get API_URL+path
  end

  def self.method_missing name, *args
    case name.to_s.split("get_").last
    when /user_info/
      if args.first.class == String
        # unauthenticated user
        get_api "/user/show/#{args.first}"

      elsif args.first.class == Hash
        # authenticated user
        get_api "/user/show?#{args.first.map{ |k,v|  "#{k}=#{v}"}.join("&")}"
      end
    else
      super(name, args)

    end
  end

# get stuff from git.config
  def self.git_config
    # first, lets try to get the username
    username = `git config --global --get github.user`.strip
    token = `git config --global --get github.token`.strip
    throw "No github config found" if username.empty? or token.empty?
    return username, token
  end
end
