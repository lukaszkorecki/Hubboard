# Gets user info from github using GH's API
# gu = Github::User.new.info user_name
# puts gu.data.inspect
#
# #  or you can pass a block if you're going to communicate with
# the API using something else than top level class functions
#
# gu = Github::User.new.info(user_name) do | name |
#     Github.get_user_info name
# end
#
# puts gu.data.inspect
#
# If you want to authenticate pass a hash with params named as in
# the GH's docs
#
# gu = Github::User.new.info( {:login => user_name, :token => token})
#
# puts gu.data.inspect

module Github
  class User

    attr_reader :data
    def initialize user=nil
      info user unless user.nil?
    end

    def info user=nil
      raise '[Exception] No user name passed' if user.nil?
      @data = (YAML::load yield(user))['data']['user']
      self
    end
  end
end
