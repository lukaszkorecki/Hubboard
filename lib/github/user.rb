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

    attr_reader :company, :name, :gravatar_id, :created_at,
            :location, :blog, :public_gist_count, :public_repo_count,
            :following_count, :id, :type, :followers_count, :login, :email,
            :data

    def initialize user_d
      raise '[Exception] No user name or login/token passed' if user_d.nil?
      d = if block_given?
            (YAML::load yield(user_d))
          else
            Github.get_user_info user_d
          end
      @data = d['data']['user']
      @data.each do | name, val |
        instance_variable_set :"@#{name}", val
      end
      self
    end

    def avatar
      @avatar ||= "http://www.gravatar.com/avatar/"+@gravatar_id+"?s=48"
    end
    def to_html
      html =<<-HTML
        <p><b>#{@name}</b> #{@login}</p>
        <p>Since: #{@created_at}</p>
        <p>Company: #{@company}</p>
        <p><a href="#{@blog}">#{@blog}</p>
        <p>
          <ul>
            <li>Followers count: #{@followers_count}</li>
            <li>Following count: #{@following_count}</li>
            <li>Repo count: #{@public_repo_count}</li>
            <li>Gist count: #{@public_gist_count}</li>
          </ul>
        </p>
      HTML
      html
    end
  end
end


