require 'net/http'
require 'crack'

class MembersListApiCall
	def get_data(search_term)
		url = url_builder(search_term)
		req = request(url)
		res = response(url, req)
		convert_xml_to_json(res)
	end

	private

	def url_builder(search_term)
		url = "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/biographyinterest=#{search_term}/"
		URI.parse(url)
	end

	def request(uri)
		Net::HTTP::Get.new(uri)
	end

	def response(uri, req)
		res = Net::HTTP.new(uri.host, uri.port)
		res.request(req).body
	end

	def convert_xml_to_json(xml)
		Crack::XML.parse(xml)
	end
end