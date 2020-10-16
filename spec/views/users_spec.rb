require 'rails_helper.rb'	
require 'spec_helper'	

describe 'the signin process', type: :feature do	
  before :each do	
    @test_user = User.create(name: 'Alex', email: 'alex@gmail.com')	
  end	
  it 'Display message when creating a new user' do	
    visit '/users/sign_up'	

    fill_in 'user_name', with: '123123a'	
    fill_in 'user_email', with: '123a1@gmail.com'	
    fill_in 'user_password', with: '123123a'	
    fill_in 'user_password_confirmation', with: '123123a'	

    click_button('Sign up')	

    expect(page).to have_content 'Welcome! You have signed up successfully.'	
  end	
  it 'Display message when logged in' do	
    visit '/users/sign_in'	

    fill_in 'user_email', with: '123@gmail.com'	
    fill_in 'user_password', with: '123123'	

    click_button('Log in')	

    expect(page).to have_content 'Signed in successfully.'	
  end	
end