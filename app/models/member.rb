class Member

	attr_reader :name, :member_id, :image_link, :dods_id, :house, :party

	def initialize(member_data)
		@name = member_data['FullTitle']
    @member_id = member_data['Member_Id']
    @dods_id = member_data['Dods_Id']
    @house = member_data['House']
    @party = member_data['Party']
    @image_link = image_link_builder(@dods_id)
	end

  private

  def image_link_builder(id)
    "http://www.dodspeople.com/photos/#{id}.jpg"
  end

end