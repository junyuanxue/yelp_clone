require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    sign_up_correctly
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'user can only leave one review per restaurant' do
    sign_up_correctly
    leave_review
    leave_review
    expect(page).to have_content "has reviewed this restaurant already"
  end
end
