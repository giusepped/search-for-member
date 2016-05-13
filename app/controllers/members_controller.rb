require 'api_calls/members_list_api_call'

class MembersController < ApplicationController
	def index
		if (($redis.get('json_data') != nil && $redis.get('json_data') != 'No results'))
			data = JSON.load($redis.get('json_data'))
			@members_array = data['Members']['Member']
			@members_list =[]
			@members_array.each do |member_data|
				member = Member.new()
				member.set_properties(member_data)
				@members_list.push(member)
			end
			$redis.set('members_list', @members_list)
		elsif ($redis.get('json_data') == 'No results')
			@error_message = $redis.get('json_data')
		end
	end

	def fetch
		$redis.del('json_data')
		$redis.del('members_list')
		members_list_api_call = MembersListApiCall.new
		members_list = members_list_api_call.get_data(params[:search_term])
		if (members_list["Members"] != nil)
			$redis.set('json_data', members_list.to_json)
		else
			$redis.set('json_data', 'No results')
		end
		redirect_to members_path
	end
end
