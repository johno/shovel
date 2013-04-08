#Shovel

##What is it?

A scraper for the Boise Weekly and Boise State events, with more to come.

##Why do I care?

  1. We, [at Gertuko](https://github.com/gertuko), seek to provide a better way to find out what's going on, and Shovel is the way that we aggregate that content.
  2. We are currently working on adding additional scraping features for other websites with events content, so please feel free to contribute.
  3. The data that Shovel produces will eventually feed an awesome events app called [Gertuko](http://www.gertuko.com).


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
