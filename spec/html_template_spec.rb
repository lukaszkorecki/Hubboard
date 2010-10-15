require File.dirname(__FILE__)+'/../views/html_templates'
require File.dirname(__FILE__)+'/../lib/github/user'
require 'yaml'
describe "HtmlTemplate" do
  describe "User template" do
    before :each do
      @user_yaml ||= File.new(File.dirname(__FILE__)+'/fixtures/user.yaml').read
    @user_obj ||= Github::User.new('loluser') do
      @user_yaml
    end
    end
    it 'should produce a nice html containgin user info and github link' do
      html = HtmlTemplates::User.to_html(@user_obj)
      html.should include("
        <a href='http://github.com/loluser'>loluser</a>
        <br>
        <a href='http://coffeesounds.com'>http://coffeesounds.com</a>")
    end
    it 'should render github counters' do
      exp = "<p>
        <ul>
          <li>Followers: 22</li>
          <li>Repos: 18</li>
          <li>Gists: 70</li>
        </ul>
      </p>"
      html = HtmlTemplates::User.to_html(@user_obj)
      html.should include exp
    end
  end
end
