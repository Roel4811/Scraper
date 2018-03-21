require 'nokogiri'
require 'open-uri'

class BolScraperService

  def call
    url = "https://www.bol.com/nl/l/anker-powerbanks/N/18135/filter_N/4294856588/?view=tiles"
    response = open(url)
    html = Nokogiri::HTML(response)

    products = html.search('#js_items_content li.product-item--column')
    products.each do |product|
      name = product.search('a.product-title').text.strip
      image = product.search('a.product-image img').attr('src').text.strip
      link = product.search('a.product-image').attr('href').value
      price = product.search('meta').attr('content').value.to_f
      rating = product.search('.rating-stars').attr('title').value
      review_amount = product.search('.rating-stars__rating-count').text.split('').map {|x| x[/\d+/]}.join.to_i
      available = product.search('.medium--is-visible').text.blank? ? false : true
      latest_order_time = product.search('.medium--is-visible').text.slice(0..80).strip
      # puts "#{name}--#{price}--#{rating}"
      # puts "#{name}--#{price}--#{review_amount}"
      puts "#{name}--#{price}--#{latest_order_time}"
      # puts "#{name}--#{price}--#{link}"
      # puts "#{name}--#{price}--#{latest_order_time}"
    end
    binding.pry



  end

end


# url
# https://www.bol.com/nl/l/elektronica/powerbanks/N/18135/suggestionType/category/suggestedFor/powerbank/originalSearchContext/media_all/originalSection/main/index.html?_requestid=1015069
# powerbanks = /N/18135
# anker = 4280701110
# samsung = 4294937500
# xiaomi = 4282619856
# trust = 4294856588
