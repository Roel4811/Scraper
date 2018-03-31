require 'nokogiri'
require 'open-uri'

class BolScraperService

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    # url = "https://www.bol.com/nl/l/anker-powerbanks/N/18135/filter_N/4294856588/?page=2&view=tiles"
    response = open(url)
    html = Nokogiri::HTML(response)

    records = []
    products = html.search('#js_items_content li.product-item--column')
    products.each_with_index do |pr, i|
      product = {}
      product['name'] = pr.search('a.product-title').text.strip
      product['store_id'] = pr.attr("data-id").to_i
      product['image'] = pr.search('a.product-image img').attr('src').text.strip
      product['link'] = pr.search('a.product-image').attr('href').value
      product['price'] = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[2]/span/div/div/div/meta").attr("content").value.to_f
      product['rating'] = pr.search('.rating-stars').attr('title').value
      product['review_amount'] = pr.search('.rating-stars__rating-count').text.split('').map {|x| x[/\d+/]}.join.to_i
      product['available'] = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[3]/div/text()").text.blank? ? false : true
      product['availability'] = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[3]/div/text()").text.strip

      records << product
      # product = Product.find_or_initialize_by(store_id: store_id)
      # product.name = name if name.present?
      # product.image = image if image.present?
      # product.link = link if link.present?
      # product.price = price if price.present?
      # product.rating = rating if rating.present?
      # product.review_amount = review_amount if review_amount.present?
      # product.available = available if available.present?
      # product.availability = availability if availability.present?
      #
      # product.save if product.new_record? || product.changed?
    end
    records
  end
end


# url
# https://www.bol.com/nl/l/elektronica/powerbanks/N/18135/suggestionType/category/suggestedFor/powerbank/originalSearchContext/media_all/originalSection/main/index.html?_requestid=1015069
# powerbanks = /N/18135
# anker = 4280701110
# samsung = 4294937500
# xiaomi = 4282619856
# trust = 4294856588
