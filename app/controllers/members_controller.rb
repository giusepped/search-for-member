require 'api_calls/members_list_api_call'

class MembersController < ApplicationController
	def index
		if ($redis.get('json_data') != nil && $redis.get('json_data') != 'No results')
			@members_array = get_json_data
			@members_array = [@members_array] unless @members_array.kind_of?(Array)
			@members_array.map!{ |member_data| Member.new(member_data) }
			format_as_json(@members_array)
			
		elsif $redis.get('json_data') == 'No results'
			@error_message = $redis.get('json_data')
		end
	end

	def fetch
		clear_redis
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
		@member = Member.new(member_data)
		format_as_json(@member)
	end

	private

	def get_json_data
		data =JSON.load $redis.get('json_data')
		data['Members']['Member']
	end

	def clear_redis
		$redis.flushall
	end

	def format_as_json(data)
		respond_to do |format|
			format.html
			format.json { render json: data }
		end
	end
end
