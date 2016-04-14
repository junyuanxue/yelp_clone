require 'rails_helper'

feature 'restaurants' do
  context 'no restaurant have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants do' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    context 'user not logged in' do
      scenario 'user has to log in before creating a restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).to have_content 'Log in'
      end
    end

    context 'user logged in' do
      before do
        User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
        user_sign_in
      end

      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc) { Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create(name: 'KFC') }

    context 'user not logged in' do
      scenario 'user must sign in before editing a restaurant' do
        visit '/restaurants'
        expect(page).not_to have_content 'Edit KFC'
      end
    end

    context 'user logged in' do
      before do
        User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
        user_sign_in
      end

      scenario 'let a user edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'a user can only edit restaurants they created' do
        click_link 'Sign out'
        User.create(email: 'other@user.com', password: 'otheruser', password_confirmation: 'otheruser')
        user_sign_in(email: 'other@user.com', password: 'otheruser')
        expect(page).not_to have_content 'Edit KFC'
      end
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create(name: 'KFC') }

    context 'user not logged in' do
      scenario 'user must sign in before removing a restaurant' do
        visit '/restaurants'
        expect(page).not_to have_content 'Delete KFC'
      end
    end

    context 'user logged in' do
      before do
        User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
        user_sign_in
      end

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'a user can only remove a restaurant they created' do
        click_link 'Sign out'
        User.create(email: 'other@user.com', password: 'otheruser', password_confirmation: 'otheruser')
        user_sign_in(email: 'other@user.com', password: 'otheruser')
        expect(page).not_to have_content 'Delete KFC'
      end
    end
  end
end
