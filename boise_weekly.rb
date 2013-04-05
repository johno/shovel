require 'nokogiri'
require 'mechanize'
require 'open-uri'

module Shovel
  class BoiseWeekly
    
    @base_url = 'http://www.boiseweekly.com/boise/EventSearch?narrowByDate='
    
    def self.scrape options = {}
      
      sub_url = case options[:when]
                when :today then 'Today'
                when :next_week then 'Next%207%20Days' 
                when :this_weekend then 'This%20Weekend'
                else 'Today'
                end
      
      url = @base_url + sub_url
      url << '&neighborhood=939889'
      url << options[:param] if options[:param]
      
      page = Nokogiri::HTML open url
      page.css('.EventListing').each do |listing|
        
        event_params = {}
        listing.css('h3').css('a').each do |event_href|
          next unless event_href['href'].include? 'Event?oid='
          event_params[:title] = event_href.text.gsub(/\s+/, ' ').strip
          event_params[:description] = strip_description listing
          event_params[:category] = strip_category listing
          event_params[:address] = strip_address listing
          event_params[:venue] = strip_venue listing
          event_params[:phone] = strip_phone listing
          event_params[:bw_id] = strip_oid event_href
          event_params[:cost] = strip_cost listing
          event_params[:date] = strip_date listing
        end
        
        unless event_params.blank?
          event = Event.new event_params
          event.save if event.valid?
        end
      end
    end
    
    def self.strip_oid event_href
      return if event_href.nil?
      event_href['href'].split('?oid=').second.gsub(/\s+/, ' ').strip
    end
    
    def self.strip_date listing
      return if listing.nil?
      
      # Here, since the date isn't actually in any type of container,
      # we must grab all the other textual information from the parent
      # div and remove it, thus leaving us with our desired date string.
      header_stuff_we_dont_want = listing.css('h3').text
      category_stuff_we_dont_want = listing.css('.eventCategories').text
      description_stuff_we_dont_want = listing.css('p.descripText').text
      
      all_stuff = listing.text
      all_stuff.slice! header_stuff_we_dont_want
      all_stuff.slice! category_stuff_we_dont_want
      all_stuff.slice! description_stuff_we_dont_want
      all_stuff
    end
    
    def self.strip_venue listing
      return if listing.nil?
      listing.css('.listingLocation').css('a').first.text
    end
    
    def self.strip_category listing
      return if listing.nil?
      category = listing.css('.eventCategories').css('a').text
      Categories::BoiseWeekly.parse_from_string category
    end
    
    def self.strip_address listing
      return if listing.nil?
      
      address = listing.css('.listingLocation').text.split(')').second
        .gsub(/\s+/, ' ').gsub(listing.css('.listingLocation').css('.locationRegion').text, '')
        .strip
        
      address = address.split(' ')
      address.pop  # Remove phone number.
      address = address.join(' ') << " Boise, Idaho"
    end
    
    def self.strip_phone listing
      return if listing.nil?
      
      listing.css('.listingLocation').text.split(')').second
        .gsub(/\s+/, ' ').gsub(listing.css('.listingLocation').css('.locationRegion').text, '')
        .strip.split(' ').pop
    end
    
    def self.strip_description listing
      return if listing.nil?
      text = listing.css('p.descripTxt').text.gsub(/\s+/, ' ').strip.split(' ')
      text.pop  # Remove price.
      text.join(' ')
    end
    
    def self.strip_cost listing
      return if listing.nil?
      listing.css('p.descripTxt').text.gsub(/\s+/, ' ').strip.split(' ').pop.downcase
    end
  end
end