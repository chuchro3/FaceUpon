require 'rubygems'
require 'json'
require 'open-uri'
require 'pp'

module GrouponApiParser


  @@client_id = "60e2f457f30d31204d8a60a2f66f80e573110f35"
  @@count = 0

  def GrouponApiParser.get_deals

    old_db_size = GrouponDeal.all.size

    get_divisions

    db_size_diff = GrouponDeal.all.size - old_db_size
    puts "Database contains " + db_size_diff.to_s + " new deals! (" + GrouponDeal.all.size.to_s + " total)"

  end

  def GrouponApiParser.get_divisions


    url = "https://api.groupon.com/v2/divisions.json?client_id=" + @@client_id

    parsed_json = parse_url(url)

    @divisions_hash = parsed_json['divisions']

    print "Saving "
    @divisions_hash.each do |division|
      get_deals_by_division(division['id'])
      #store_division(division['name'])
    end

  end

  def GrouponApiParser.get_deals_by_division(division)

    url = "https://api.groupon.com/v2/deals.json?division_id=" + division + "&client_id=" + @@client_id
    
    parsed_json = parse_url(url)

    @deals_hash = parsed_json['deals']

    begin
    @deals_hash.each do |deal|
      if (isDuplicate?(deal)) then
          next
      end
      groupon_deal = GrouponDeal.new(
        :groupon_type      => deal['type'],
        :isNowDeal         => deal['isNowDeal'],
        :pitchHtml         => deal['pitchHtml'],
        :sidebarImageUrl   => deal['sidebarImageUrl'],
        :status            => deal['status'],
        :vip               => deal['vip'],
        :endAt             => deal['endAt'],
        :division_id       => deal['division']['id'],
        :division_lat      => deal['division']['lat'],
        :division_lng      => deal['division']['lng'],
        :division_name     => deal['division']['name'],
        :announcementTitle => deal['announcementTitle'],
        :highlightsHtml    => deal['highlightsHtml'],
        :merchant_name     => deal['merchant']['name']
      )
      groupon_deal.save
      
      @@count += 1
      #puts ("\"" + deal['highlightsHtml'] + "\" saved (" + @@count.to_s + ")").html_safe
      if @@count % 500 == 0
        print @@count.to_s
      elsif @@count % 2 == 0
        print "."
      end
    end
    rescue => err
      raise "Exception: " + err.to_s
    end
  end

  def GrouponApiParser.isDuplicate?(deal)
    groupon_deals = GrouponDeal.all
    groupon_deals.each do |groupon_deal|
      if (deal['merchant']['name'] == groupon_deal[:merchant_name])
        return true
      end
    end
      return false
  end


  def GrouponApiParser.store_division(division_name)
    division = Division.new(:name => division_name)
    division.save
  end

  #parses the url and returns a parsed json
  def GrouponApiParser.parse_url(url)

    uri = URI.parse(url)
    return JSON.parse(uri.open.read)

  end

  def GrouponApiParser.update_time_file
    File.open('log/updatetime.log', 'w') do |f|
      f.puts Time.now.to_s
    end
  end

  #reads the time file and returns the time stored
  def GrouponApiParser.get_time_file
    File.open('log/updatetime.log', 'r') do |f|
      return f.gets
    end
  end

  def GrouponApiParser.one_method()
    client_id = "60e2f457f30d31204d8a60a2f66f80e573110f35"
    url = "https://api.groupon.com/v2/divisions.json?client_id=" + client_id

    uri = URI.parse(url)
    parsed_json JSON.parse(uri.open.read)


    @divisions_hash = parsed_json['divisions']

    @divisions_hash.each do |division|
      divisionid = division['id']
      url = "https://api.groupon.com/v2/deals.json?division_id=" + divisionid + "&client_id=" + client_id
    
      uri = URI.parse(url)
      parsed_json JSON.parse(uri.open.read)


      @deals_hash = parsed_json['deals']

      @deals_hash.each do |deal|
        groupon_deal = GrouponDeal.new(
          :groupon_type    => deal['type'],
          :isNowDeal       => deal['isNowDeal'],
          :pitchHtml       => deal['pitchHtml'],
          :sidebarImageUrl => deal['sidebarImageUrl'],
          :status          => deal['status'],
          :vip             => deal['vip'],
          :endAt           => deal['endAt'],
          :division_id     => deal['division']['id'],
          :division_lat    => deal['division']['id'],
          :division_lng    => deal['division']['id'],
          :division_name   => deal['division']['id']
        )
        groupon_deal.save!
      end
    end

  end


end
