class Member

	attr_reader :name, :member_id, :image_link, :dods_id, :house, :party

	def set_properties(member_data)
		@name = member_data['Member']['FullTitle']
    @member_id = member_data['Member']['Member_Id']
    @dods_id = member_data['Member']['Dods_Id']
    @house = member_data['Member']['House']
    @party = member_data['Member']['Party']['#text']
    @image_link = image_link_builder(@dods_id)
	end

  private

  def image_link_builder(id)
    "http://www.dodspeople.com/photos/#{id}.jpeg"
  end

end