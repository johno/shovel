require 'oj'
require './boise_weekly.rb'

data  =  Shovel::BoiseWeekly.scrape  when: 'next_week', verbose: true
print  Oj::dump  data
print  "\n"

