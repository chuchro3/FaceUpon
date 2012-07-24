class AddActiveStatusToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :startAt, :timestamp
    add_column :groupon_deals, :endAt, :timestamp
    add_column :groupon_deals, :active_status, :boolean
  end
end
