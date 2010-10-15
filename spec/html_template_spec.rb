require File.dirname(__FILE__)+'/../views/html_templates'
describe "HtmlTemplate" do
  describe "User template" do
    before :each do
      class Ob; def method_missing(*args); return args.first.to_s; end; end
      @user_obj = Ob.new
    end
    it 'should produce a nice html template using objects instance variables' do
      html = HtmlTemplates::User.to_html(@user_obj)
      expected = "<div>
      <p>
        <a href='http://github.com/login'>login</a>
        <br>
        <a href='blog'>blog</a>
        <br>
        Member since: created_at
      </p>
      <p>
        <ul>
          <li>Followers: followers_count</li>
          <li>Repos: public_repo_count</li>
          <li>Gists: public_gist_count</li>
        </ul>
      </p>"
      html.strip.should == expected.strip
    end
  end
end
