class GrouponDeal < ActiveRecord::Base
  acts_as_indexed :fields => [:announcementTitle, :pitchHtml, :division_name, :division_id, :title, :merchant_name]

  attr_protected

  validates_presence_of :groupon_type

  def expired?
    Time.now - Time.parse(endAt) > 60*60*12
  end
end
