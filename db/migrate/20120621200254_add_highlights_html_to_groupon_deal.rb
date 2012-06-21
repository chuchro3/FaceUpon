class AddHighlightsHtmlToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :highlightsHtml, :text
  end
end
