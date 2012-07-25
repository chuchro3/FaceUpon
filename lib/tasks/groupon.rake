#require File.expand_path(File.dirname(__FILE__) + '/../groupon_api_parser.rb')
require 'groupon_api_parser.rb'

namespace :db do
  task :groupon, [:isTest, :updateStatusOnly, :chicagoOnly] => :environment do |t, args|
    args.with_defaults(:isTest => 'false', :updateStatusOnly => 'false', :chicagoOnly => 'false')
    isTest = args[:isTest]
    updateStatusOnly = args[:updateStatusOnly]
    chicagoOnly = args[:chicagoOnly]
    
    puts Time.now

    logged_time = Time.now - 60*60*22
    logged_time = Time.parse(GrouponApiParser.get_time_file) unless GrouponApiParser.get_time_file.nil?
    time_since_update = Time.now - logged_time
    
    #only calls api every set number of hours after successful call
    if (time_since_update < 60*60*2 && isTest == 'false')
      hours = (time_since_update/3600).to_i
      minutes = (time_since_update/60 - hours * 60).to_i
      seconds = (time_since_update - (minutes * 60 + hours * 3600)).to_i
      puts hours.to_s + ":" + minutes.to_s + ":" + seconds.to_s + " since last successful update.\n\n"
    else

      
      #Rake::Task['db:reset'].invoke

      if (updateStatusOnly == 'false') 
        tStart_get = Time.now 
      
        @deals_hash = GrouponApiParser.get_deals(chicagoOnly)

        tDiff_get = Time.now - tStart_get
        puts "    -> " + tDiff_get.to_s + " s"


        tStart_save = Time.now

        Rake::Task['db:save_deals'].invoke
      
        tDiff_save = Time.now - tStart_save
        puts "    -> " + tDiff_save.to_s + " s"

        GrouponApiParser.update_time_file
      end

    end

      Rake::Task['db:update_status'].invoke


      puts "Success!\n\n"

  end
  

  task :save_deals => :environment do
    
    old_db_size = GrouponDeal.all.size
    print "Saving "
    
    @deals_hash.each do |deals|
      deals.each_with_index do |deal, index|
        
        if index % 600 == 0
          print "."
        end

        if (GrouponApiParser.isDuplicate?(deal)) then
          deal['options'].each do |option_hash|
            DealOption.find_by_title(option_hash['title']).update_attributes(
              :isSoldOut                => option_hash['isSoldOut'],
              :soldQuantity             => option_hash['soldQuantity'],
              :soldQuantityMessage      => option_hash['soldQuantityMessage']
            )
          end
          next
        end
        groupon = GrouponDeal.create(
          :groupon_type           => deal['type'],
          :isNowDeal              => deal['isNowDeal'],
          :pitchHtml              => deal['pitchHtml'],
          :sidebarImageUrl        => deal['sidebarImageUrl'],
          :status                 => deal['status'],
          :vip                    => deal['vip'],
          :startAt                => deal['startAt'].blank? ? nil : Time.parse(deal['startAt']),
          :endAt                  => deal['endAt'].blank? ? nil : Time.parse(deal['endAt']),
          :active_status          => true,
          :division_id            => deal['division']['id'],
          :division_lat           => deal['division']['lat'],
          :division_lng           => deal['division']['lng'],
          :division_name          => deal['division']['name'],
          :announcementTitle      => deal['announcementTitle'],
          :highlightsHtml         => deal['highlightsHtml'],
          :merchant_name          => deal['merchant']['name'],
          :isSoldOut              => deal['isSoldOut'],
          :dealUrl                => deal['dealUrl'],
          :websiteUrl             => deal['websiteUrl'],
          :title                  => deal['title'],
          :shortAnnouncementTitle => deal['shortAnnouncementTitle'],
          :finePrint              => deal['finePrint']
        )

        deal['options'].each do |option_hash|
          groupon.DealOptions << DealOption.create(
            :buyUrl                   => option_hash['buyUrl'],
            :details_description      => option_hash['details'].first['description'],
            :discountPercent          => option_hash['discountPercent'],
            :discount_formattedAmount => option_hash['discount']['formattedAmount'],
            :expiresAt                => option_hash['expiresAt'],
            :isSoldOut                => option_hash['isSoldOut'],
            :maximumPurchaseQuantity  => option_hash['maximmumPurchaseQuantity'],
            :price_formattedAmount    => option_hash['price']['formattedAmount'],
            :soldQuantity             => option_hash['soldQuantity'],
            :soldQuantityMessage      => option_hash['soldQuantityMessage'],
            :title                    => option_hash['title'], 
            :value_formattedAmount    => option_hash['value']['formattedAmount']
          )
        end
        #puts ("\"" + deal['highlightsHtml'] + "\" saved (" + index.to_s + ")").html_safe

      end
    end

    db_size_diff = GrouponDeal.all.size - old_db_size
    puts "\nDatabase contains " + db_size_diff.to_s + " new deals! (" + GrouponDeal.all.size.to_s + " total)"

  end

  task :update_status => :environment do
    
    print "Updating active statuses "
    start_time = Time.now

    active_deals = GrouponDeal.where("active_status = ? ", true)

    deals_that_expired = 0
    active_deals.each_with_index do |deal, index|
      if deal.expired?
        deal.update_attribute :active_status, false
        deals_that_expired += 1
      end
      print '.' if index % 200 == 0
    end

    puts "Success!"
    puts "#{deals_that_expired} newly expired deals"

    puts "    -> #{(Time.now - start_time).round} seconds"
  end

end
