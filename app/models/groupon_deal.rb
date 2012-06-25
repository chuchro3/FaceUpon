class GrouponDeal < ActiveRecord::Base
  #attr_accessible :announcementTitle, :endAt, :isNowDeal, :pitchHtml, :highlightsHtml, :groupon_type, :sidebarImageUrl, :division_lng, :division_lat, :division_name, :division_id, :vip, :status
  attr_protected

  #validate :function_name
  #validate_length_of :division_id, 1..15, :too_short => "message here", :too_long => "different message here"
  validates_presence_of :groupon_type
  
  #def function_name
    #:division_id > 0
  #end

end
