class GrouponDeal < ActiveRecord::Base
  attr_accessible :announcementTitle, :endAt, :isNowDeal, :pitchHtml, :highlightsHtml, :groupon_type, :sidebarImageUrl, :division_lng, :division_lat, :division_name, :division_id, :vip, :status
end
