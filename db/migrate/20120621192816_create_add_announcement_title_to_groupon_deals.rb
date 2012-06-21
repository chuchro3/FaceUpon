class CreateAddAnnouncementTitleToGrouponDeals < ActiveRecord::Migration
  def change
    create_table :add_announcement_title_to_groupon_deals do |t|
      t.text :announcementTitle

      t.timestamps
    end
  end
end
