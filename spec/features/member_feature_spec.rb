require 'rails_helper'

feature 'members' do

	context 'no search has been made yet' do
		scenario 'should display an input box and a "Find" button' do
			visit search_members_path
			expect(page).to have_selector('input[name="search_term"]')
			expect(page).to have_button 'Find'
		end
	end

	context 'after the user searches for "housing"' do
		before(:each) do
	        visit search_members_path
			fill_in 'search_term', with: 'housing'
			click_button 'Find'
		end

		scenario 'should redirect to index page' do
			expect(current_path).to eq('/members')
		end
	end

end