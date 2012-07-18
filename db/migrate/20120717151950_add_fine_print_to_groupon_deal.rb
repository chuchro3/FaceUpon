class AddFinePrintToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :finePrint, :text
  end
end
