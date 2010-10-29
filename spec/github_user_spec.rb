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
  it 'should return false if data couldnt be retreived' do
    u  = User.new('loluser') { false }
    u.data.should == nil
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
end
