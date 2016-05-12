require_relative '../../lib/api_calls/members_list_api_call'

class MembersController < ApplicationController
	def index
		if ($redis.get('json_data') != nil)
			data = JSON.load($redis.get('json_data'))
			@members_array = data['Members']['Member']
			@members_list =[]
			@members_array.each do |member_data|
				member = Member.new()
				member.set_properties(member_data)
				@members_list.push(member)
			end
			$redis.set('members_list', @members_list)
		end
	end

	def fetch
		$redis.del('json_data')
		$redis.del('members_list')
		members_list_api_call = MembersListApiCall.new
		members_list = members_list_api_call.get_data(params[:search_term])
		$redis.set('json_data', members_list.to_json)
		redirect_to members_path
	end
end
