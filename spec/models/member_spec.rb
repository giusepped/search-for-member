require 'rails_helper'
require 'response_stubs/json_member_data_stub'

describe Member, type: :model do

	describe '#initialize' do
		before(:each) do
			@member = Member.new(JSON.parse(JSON_MEMBER_DATA_STUB, :quirks_mode => true))
		end
		it 'sets the name correctly' do
			expect(@member.name).to eq 'The Lord Bradshaw'
		end

		it 'sets the member_id correctly' do
			expect(@member.member_id).to eq '2483'
		end

		it 'sets the dods_id correctly' do
			expect(@member.dods_id).to eq '26640'
		end

		it 'sets the House correctly' do
			expect(@member.house).to eq 'Lords'
		end

		it 'sets the party correctly' do
			expect(@member.party).to eq 'Liberal Democrat'
		end

		it 'generates the link for the image' do
			expect(@member.image_link).to eq 'http://www.dodspeople.com/photos/26640.jpg'
		end
	end

end