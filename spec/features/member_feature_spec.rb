require 'rails_helper'

feature 'members' do

	context 'no search has been made yet' do
		scenario 'should display an input box and a "Find" button' do
			visit search_members_path
			expect(page).to have_selector('input[name="search"]')
			expect(page).to have_button 'Find'
		end
	end

end