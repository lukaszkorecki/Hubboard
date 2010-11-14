class Preferences
  def initialize
    @file_path = File.expand_path '~/.hubboard/settings'
  end
  def gh_data
    begin
     @gh_data ||= YAML::load_file @file_path
    rescue
      return false
    end
    @gh_data
  end

  def gh_data!
     @gh_data = YAML::load_file @file_path
  end

  def store_gh_data username, token
    data = { :username => username, :token => token }
    File.open(@file_path, 'w') do | file |
      YAML::dump( data , file)
    end
    @gh_data = data
  end
end
