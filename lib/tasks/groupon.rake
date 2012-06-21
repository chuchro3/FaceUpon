#require File.expand_path(File.dirname(__FILE__) + '/../groupon_api_parser.rb')
require 'groupon_api_parser.rb'

namespace :db do
  task :groupon => :environment do
    Rake::Task['db:reset'].invoke

    puts "Retrieving Groupon deals.."
    GrouponApiParser.get_deals
    puts "Success!"
  end
end
