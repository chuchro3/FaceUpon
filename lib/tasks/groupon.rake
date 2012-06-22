#require File.expand_path(File.dirname(__FILE__) + '/../groupon_api_parser.rb')
require 'groupon_api_parser.rb'

namespace :db do
  task :groupon => :environment do
    puts Time.now

    time_since_update = Time.now - Time.parse(GrouponApiParser.get_time_file)
    if (time_since_update < 60*60*22)
      hours = (time_since_update/3600).to_i
      minutes = (time_since_update/60 - hours * 60).to_i
      seconds = (time_since_update - (minutes * 60 + hours * 3600)).to_i
      puts hours.to_s + ":" + minutes.to_s + ":" + seconds.to_s + " since last successful update.\n\n"
    else

      Rake::Task['db:reset'].invoke

      puts "Retrieving Groupon deals.."
    
      tStart = Time.now 
    
      GrouponApiParser.get_deals
    
      tDiff = Time.now - tStart
      puts "    -> " + tDiff.to_s + " s"

      GrouponApiParser.update_time_file

      puts "Success!\n\n"
    end
  end
end
