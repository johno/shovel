#shovel

A scraper for the Boise Weekly and BSU Events.

##Usage

Some examples of the possible commands.

```ruby
Shovel::BoiseWeekly.scrape
Shovel::BoiseWeekly.scrape :next_week
Shovel::BoiseWeekly.scrape :this_weekend
Shovel::BoiseWeekly.scrape :next_seven_days, param: '&page=2'
Shovel::BoiseWeekly.scrape :next_seven_days, param: '&page=3'
Shovel::BoiseState.scrape
```

##Contributing

  1. Fork it
  2. Create your feature branch (git checkout -b my-new-feature)
  3. Commit your changes (git commit -am 'Added some feature')
  4. Push to the branch (git push origin my-new-feature)
  5. Create new Pull Request