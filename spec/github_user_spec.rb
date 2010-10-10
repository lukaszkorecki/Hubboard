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
  it 'should throw excpetion if no user is passed' do
    pending
     User.new.info.should_raise '[Exception] No user name passed'

  end
  it 'should set user ifno via block if name given' do
    u = User.new.info('loluser') do
      @user_yaml
    end
    u.data.should == @user_data['data']['user']
  end
  
  
  
end
