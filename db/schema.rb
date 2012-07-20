# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120720161242) do

  create_table "add_announcement_title_to_groupon_deals", :force => true do |t|
    t.text     "announcementTitle"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "deal_options", :force => true do |t|
    t.integer  "groupon_deal_id"
    t.integer  "soldQuantity"
    t.boolean  "isSoldOut"
    t.string   "value_formattedAmount"
    t.string   "soldQuantityMessage"
    t.text     "title"
    t.time     "expiresAt"
    t.string   "buyUrl"
    t.string   "price_formattedAmount"
    t.string   "discount_formattedAmount"
    t.integer  "discountPercent"
    t.text     "details_description"
    t.integer  "maximumPurchaseQuantity"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "divisions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groupon_deals", :force => true do |t|
    t.string   "groupon_type"
    t.text     "pitchHtml"
    t.boolean  "isNowDeal"
    t.string   "sidebarImageUrl"
    t.decimal  "division_lng"
    t.decimal  "division_lat"
    t.string   "division_name"
    t.string   "division_id"
    t.string   "vip"
    t.string   "status"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.text     "announcementTitle"
    t.text     "highlightsHtml"
    t.text     "merchant_name"
    t.time     "startAt"
    t.time     "endAt"
    t.boolean  "active_status"
    t.boolean  "isSoldOut"
    t.string   "buyUrl"
    t.string   "dealUrl"
    t.string   "websiteUrl"
    t.text     "title"
    t.text     "shortAnnouncementTitle"
    t.text     "options"
    t.text     "finePrint"
  end

end
