class AddAnnouncementTitleToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :announcementTitle, :text
  end
end
