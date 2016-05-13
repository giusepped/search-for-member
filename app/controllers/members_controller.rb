require 'api_calls/members_list_api_call'

class MembersController < ApplicationController
	def index
		if (($redis.get('json_data') != nil && $redis.get('json_data') != 'No results'))
			@members_array = get_json_data
			@members_array.map! do |member_data|
				member = Member.new
				member.set_properties(member_data)
				member_data = member
			end
		elsif ($redis.get('json_data') == 'No results')
			@error_message = $redis.get('json_data')
		end
	end

	def fetch
		$redis.del('json_data')
		$redis.del('members_list')
		members_list_api_call = MembersListApiCall.new
		members_list = members_list_api_call.get_data(params[:search_term])
		data_to_display = members_list['Members'] == nil ? 'No results' : members_list.to_json
		$redis.set('json_data', data_to_display)
		redirect_to members_path
	end

	def show
		id = params[:id]
		members_array = get_json_data
		member_data = members_array.select{ |member| member['Member_Id'] == id }[0]
		@member = Member.new
		@member.set_properties(member_data)
	end

	private

	def get_json_data
		data =JSON.load $redis.get('json_data')
		data['Members']['Member']
	end
end
