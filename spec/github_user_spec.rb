require File.dirname(__FILE__)+'/../lib/github/user'
require 'yaml'
include Github

describe 'User' do
  before :each do
    @user_yaml ||= File.new(File.dirname(__FILE__)+'/fixtures/user.yaml').read

    @user_data ||= YAML::load_file(File.dirname(__FILE__)+'/fixtures/user.yaml')

    @username = 'loluser'
    @token = 'loltoken'
  end
  it 'should set user ifno via block if name given' do
    u = User.new('loluser') do
      @user_yaml
    end
    u.data.should == @user_data['user']
  end

  it "should download the user data if block is not fiven" do
    Github.stub!(:get_user_info).and_return(@user_yaml)
    User.new('loluser').data.should == @user_data['user']
  end
  it "should set variables accordingly to the data retreived" do
    u = User.new('loluser') { @user_yaml }
    u.login.should == 'loluser'
    u.type.should == 'User'
    u.avatar.should == 'http://www.gravatar.com/avatar/f6681e53f53098ce1c09ae30811ac535.jpg'
  end
  it "should render summary html" do
    Github.stub!(:get_user_info).and_return(@user_yaml)
    u = User.new('loluser')

    u.to_html.gsub(/\W/,'').should == '<p><b>Łukasz Korecki</b> loluser</p>
        <p>Since: Tue Jul 14 15:00:09 +0100 2009</p>
        <p>Company: Optimor Labs</p>
        <p><a href="http://coffeesounds.com">http://coffeesounds.com</p>
        <p>
          <ul>
            <li>Followers count: 22</li>
            <li>Following count: 51</li>
            <li>Repo count: 18</li>
            <li>Gist count: 70</li>
          </ul>
        </p> '.chomp.gsub(/\W/,'')
  end
  it "should render summary html if yaml is passed via block" do
    u = User.new('loluser') { @user_yaml }

    u.to_html.gsub(/\W/,'').should == '<p><b>Łukasz Korecki</b> loluser</p>
        <p>Since: Tue Jul 14 15:00:09 +0100 2009</p>
        <p>Company: Optimor Labs</p>
        <p><a href="http://coffeesounds.com">http://coffeesounds.com</p>
        <p>
          <ul>
            <li>Followers count: 22</li>
            <li>Following count: 51</li>
            <li>Repo count: 18</li>
            <li>Gist count: 70</li>
          </ul>
        </p> '.chomp.gsub(/\W/,'')
  end
end
