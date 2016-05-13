require 'rails_helper'

feature 'members' do

	context 'no search has been made yet' do
		scenario 'should display an input box and a "Find" button' do
			visit members_path
			expect(page).to have_selector('input[name="search_term"]')
			expect(page).to have_button 'banana'
		end
	end

	context 'after the user searches for "edinburgh"' do
		before(:each) do
    		stub_request(:get, "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/biographyinterest=edinburgh/").
    		with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'data.parliament.uk', 'User-Agent'=>'Ruby'}).
    		to_return(:status => 200, :body => MEMBERS_LIST_XML, :headers => {})
  		end

		before(:each) do
	        visit members_path
			fill_in 'search_term', with: 'edinburgh'
			click_button 'Find'
		end

		scenario 'should redirect to index page' do
			expect(current_path).to eq('/members')
		end

		scenario 'should display image, name, house and party for the members' do
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'The Lord Bradshaw')
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'Member of the House of Lords')
			expect(page).to have_tag('ul', :with => { :class => 'member-2483' }, :text => 'Liberal Democrat')
			expect(page).to have_css("img[src='http://www.dodspeople.com/photos/26640.jpg']")
		end
	end

	context 'after the user searches for "aberdeen"' do 
		before(:each) do
    		stub_request(:get, "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/biographyinterest=aberdeen/").
    		with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'data.parliament.uk', 'User-Agent'=>'Ruby'}).
    		to_return(:status => 200, :body => EMPTY_MEMBERS_LIST, :headers => {})
  		end
		before(:each) do
	        visit members_path
			fill_in 'search_term', with: 'aberdeen'
			click_button 'Find'
		end

		scenario 'should display error message' do
			expect(page).to have_content('No results')
		end
	end

end