class AddDealInfoToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :isSoldOut, :boolean
    add_column :groupon_deals, :buyUrl, :string
    add_column :groupon_deals, :dealUrl, :string
    add_column :groupon_deals, :websiteUrl, :string
    add_column :groupon_deals, :title, :text
    add_column :groupon_deals, :shortAnnouncementTitle, :text
    add_column :groupon_deals, :options, :text
  end
end
