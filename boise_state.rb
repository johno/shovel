require 'nokogiri'
require 'mechanize'
require 'open-uri'

module Shovel
  class BoiseState
    
    @base_url = 'http://events.boisestate.edu'
    
    def self.scrape options = {}
      events = []
      page = Nokogiri::HTML open @base_url
      page.css('.upcoming_events').each do |event|
        
        params = {}
        params[:date] = strip_date event
        params[:cost] = strip_cost event
        params[:title] = event.css('h4').text.strip
        if event.css('.event_meta').css('li')[2] 
          params[:venue] = event.css('.event_meta').css('li')[2].css('p').text
        end
        params[:address] = event.css('.event_meta').css('li').last.css('p').text
        params[:description] = event.css('.event_desc').css('p').text
        params[:category] = Categories::Gertuko::ENTERTAINMENT
        params[:bs_id] = params[:title].gsub(/\s+/, '')
        
        unless params.blank?
          events << Event.new(params)
        end
      end
      
      events
    end
    
    def self.strip_date event
      return if event.nil?
      raw_date = event.css('.event_meta').css('li').first.css('p').text.strip
      raw_date = raw_date.split('/')
      raw_date[-1] = "20" + raw_date[-1]
      raw_date.join('/')
    end
    
    def self.strip_cost event
      return if event.nil?
      return if event.css('.even_descr').text.split('$').count == 1
      event.css('.event_descr').text.split('$').second
    end
  end
end