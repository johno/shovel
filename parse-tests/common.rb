require 'date'

def parse date_str
  print date_str
  print "\n"
  date_str = date_str.clone
  date_str.gsub! ".", ""
  date_str.gsub! /-[^ ]*/, ""
  date_str.gsub! /([0-9])(:([0-9]+))?( [ap]m)/, "\\1:0\\3\\4"
  date_str.gsub! /:0([0-9]+)/, ":\\1"
  print date_str
  print "\n"
  if date_str.match /[A-Za-z]+,? [0-9:]+ [ap]m/
    date_str.sub! /^([A-Za-z]+)+s,? /, "\\1, "
    print date_str
    print "\n"
    print time = DateTime.strptime(date_str, "%a, %l:%M %P").strftime("%s")
  else
    print time = DateTime.strptime(date_str, "%a, %b %e, %l:%M %P").strftime("%s")
  end
  print "\n"
  print DateTime.strptime(time, '%s').strftime "%a, %b %e, %l:%M %P"
  print "\n"
end
