class GrouponDeal < ActiveRecord::Base
  #attr_accessible :announcementTitle, :endAt, :isNowDeal, :pitchHtml, :highlightsHtml, :groupon_type, :sidebarImageUrl, :division_lng, :division_lat, :division_name, :division_id, :vip, :status
  attr_protected

  validates_presence_of :groupon_type
  
  searchable :auto_index => true, :auto_remove => true do
    text :announcementTitle, :pitchHtml, :division_name, :division_id

    #string :division_name, :division_id

    integer :id

  end

end
