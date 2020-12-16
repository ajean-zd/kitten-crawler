require 'httparty'
require 'pry'

uri = 'https://www.rspcavic.org/adoption/Search/?animal=Cat&location=&keywords=&seed=8'

kitten_to_crawl = ENV['KITTEN'] || 'charlie'

while true
  page = 1
  while true
    response = HTTParty.get("#{uri}&page=#{page}")

    if !(response.body =~ /#{kitten_to_crawl.downcase}/i).nil?
      # THIS IS SERIOUS BUSINESS
      `noti -m '#{kitten_to_crawl.upcase} HAS ARRIVED' -t 'WAKE UP'`

      puts response.request.uri.to_s
      exit
    end

    # do we have another page?
    if (response.body =~ /page\=#{page+1}/i).nil?
      break
    else
      puts "there is another page! Checking page #{page}"
      page += 1
    end
  end

  puts "#{kitten_to_crawl} has not arrived... we'll check back later..."

  sleep 5 * 60
end
