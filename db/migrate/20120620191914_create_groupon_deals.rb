class CreateGrouponDeals < ActiveRecord::Migration
  def change
    create_table :groupon_deals do |t|
      t.string :groupon_type
      t.text :pitchHtml
      t.boolean :isNowDeal
      t.string :sidebarImageUrl
      t.decimal :division_lng
      t.decimal :division_lat
      t.string  :division_name
      t.string  :division_id
      t.string  :vip
      t.string  :status

      t.timestamps
    end
  end
end
