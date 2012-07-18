class GrouponDeal < ActiveRecord::Base
  acts_as_indexed :fields => [:announcementTitle, :pitchHtml, :division_name, :division_id]

  #attr_accessible :announcementTitle, :endAt, :isNowDeal, :pitchHtml, :highlightsHtml, :groupon_type, :sidebarImageUrl, :division_lng, :division_lat, :division_name, :division_id, :vip, :status
  attr_protected

  validates_presence_of :groupon_type

  def expired?
    Time.now - Time.parse(endAt) > 60*60*12
  end
end
