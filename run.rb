require 'oj'
require './boise_weekly.rb'

alldata = []
1.upto 100 do |i|
  data  =  Shovel::BoiseWeekly.scrape  when: 'next_week', verbose: true, param: '&page=' + i.to_s
  alldata += data
  break if data.empty?
end
print  Oj::dump  alldata
print  "\n"

