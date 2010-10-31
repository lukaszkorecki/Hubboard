require 'lib/github/feed'
require 'lib/github/user'

module Github

  # net operations
  API_URL = 'http://github.com/api/v2/yaml'
  FEED_URL = 'https://github.com/{username}.private.atom?token={token}'

  def self.get_feed username, token
    t_url = FEED_URL.sub("{username}", username).sub("{token}", token)
    uri = URI.parse t_url
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = http.request Net::HTTP::Get.new(uri.request_uri)
      response_feed  = response.body
    rescue => e
      puts "GET FEED FAIL!", e.to_yaml
      response_feed = false
    end
    return response_feed.to_s
  end

  def self.get_api path, auth=nil
    url = API_URL+path
    begin
      r = Net::HTTP.get_response URI.parse url
    rescue => e
      puts "GET API FAIL!",  e.to_yaml
      r = false
    end
    return r.body
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
