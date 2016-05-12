require_relative '../../lib/api_calls/members_list_api_call'

class MembersController < ApplicationController
	def search
	end

	def fetch
		members_list_api_call = MembersListApiCall.new
		members_list = members_list_api_call.get_data(params[:search_term])
		p members_list
		redirect_to members_path
	end
end
