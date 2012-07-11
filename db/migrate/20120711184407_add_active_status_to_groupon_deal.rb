class AddActiveStatusToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :startAt, :time
    remove_column :groupon_deals, :endAt
    add_column :groupon_deals, :endAt, :time
    add_column :groupon_deals, :active_status, :boolean
  end
end
