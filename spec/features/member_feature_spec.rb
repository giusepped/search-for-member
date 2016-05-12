require 'rails_helper'

feature 'members' do

	context 'no search has been made yet' do
		scenario 'should display an input box and a "Find" button' do
			visit members_path
			expect(page).to have_selector('input[name="search_term"]')
			expect(page).to have_button 'Find'
		end
	end

	context 'after the user searches for "edinburgh"' do
		before(:each) do
	        visit members_path
			fill_in 'search_term', with: 'edinburgh'
			click_button 'Find'
		end

		scenario 'should redirect to index page' do
			expect(current_path).to eq('/members')
		end

		scenario 'should display name, house and party for the members' do
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'The Lord Bradshaw')
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'Member of the House of Lords')
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'Liberal Democrat')
		end
	end

end