module Github
  class User
    def initialize name
      raise "Name empty error" if name.empty?
      @name = name
    end
    def information
      info  = SimpleHttp.get URI.parse "http://api.github.com"
    end
  end
end
