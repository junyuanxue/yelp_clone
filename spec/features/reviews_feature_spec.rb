require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create(name: 'KFC') }

  context 'user not logged in' do
    scenario 'user has to sign in before reviewing a restaurant' do
      visit '/restaurants'
      click_link 'Review KFC'
      expect(page).to have_content 'Log in'
    end
  end

  context 'user logged in' do
    before do
      User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      user_sign_in
    end

    scenario 'alllows users to leave a review using a form' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content ('so so')
    end
  end

  context 'deleting reviews' do
    before do
      User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      user_sign_in

      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so so'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'so so'
    end

    scenario 'deletes a review when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).not_to have_content 'so so'
      expect(page).not_to have_content '3/5'
    end

    scenario 'a user can only remove a review they created' do
      click_link 'Sign out'
      User.create(email: 'other@user.com', password: 'otheruser', password_confirmation: 'otheruser')
      user_sign_in(email: 'other@user.com', password: 'otheruser')
      click_link 'KFC'
      expect(page).not_to have_content 'Delete Review'
    end
  end
end
