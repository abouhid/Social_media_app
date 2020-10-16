require 'rails_helper.rb'

describe 'testing friendship features', type: :feature do
  before :each do
    @test_friend = User.create!({ name: 'Kelyn',
                                  email: 'kelyn@gmail.com',
                                  password: '111111',
                                  password_confirmation: '111111' })
    @test_user = User.create!({ name: 'Alex',
                                email: 'alex@gmail.com',
                                password: '111111',
                                password_confirmation: '111111' })
    @test_friend_request = User.create!({ name: 'Chuck',
                                          email: 'chuckster@gmail.com',
                                          password: '111111',
                                          password_confirmation: '111111' })
    @friendship = Friendship.create!({ user_id: @test_friend_request.id,
                                       friend_id: @test_user.id,
                                       confirmed: nil })

    @post = Post.create!({ user_id: @test_friend_request.id,
                           content: 'Test post from Chuck' })
  end

  ## Creating
  describe 'Performing actions as Kelyn' do
    before :each do
      visit 'users/sign_in'
      fill_in 'Email', with: 'kelyn@gmail.com'
      fill_in 'Password', with: '111111'
      click_button 'Log in'
      visit 'users'
    end
    it 'login was made' do
      expect(page).to have_content 'Kelyn'
    end
    it 'users is listed in users index' do
      expect(page).to have_content 'Alex'
    end

    it 'users can add friends' do
      sleep(2)
      click_link 'Add Friend'
      expect(page).to have_content 'Invite was successfully sent.'
    end

    it 'Message of Peding Request is displayed' do
      sleep(2)
      click_link 'Invite to friendship'
      expect(page).to have_content 'pending request'
    end

    it 'Resquests are displayed' do
      expect(page).to have_content 'Accept friendship'
    end

    it 'Accept invitation' do
      sleep(2)
      click_link 'Accept friendship'
      expect(page).to have_content 'Friend request was accepted.'
    end

    it 'Accept invitation button dissapears if invitation accepted' do
      sleep(2)
      click_link 'Accept friendship'
      expect(page).to_not have_content 'Accept friendship'
    end

    it 'If friendship was accepted display posts of friends in timeline' do
      visit 'users'
      click_link 'Accept friendship'
      sleep(2)
      visit 'posts'
      expect(page).to have_content 'Test post from John'
    end

    it 'If friendship was accepted create a new row for inverse friendship' do
      visit 'users'
      expect { click_link 'Accept friendship' }.to change(Friendship, :count).by(1)
    end
  end
end