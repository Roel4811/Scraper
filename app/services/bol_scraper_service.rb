require 'nokogiri'
require 'open-uri'

class BolScraperService

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    response = open(url)
    html = Nokogiri::HTML(response)

    records = []
    products = html.search('#js_items_content li.product-item--column')
    products.each_with_index do |pr, i|
      name = pr.search('a.product-title').text.strip
      store_id = pr.attr("data-id").to_i
      image = pr.search('a.product-image img').attr('src').text.strip
      link = pr.search('a.product-image').attr('href').value
      price = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[2]/span/div/div/div/meta").attr("content").value.to_f
      rating = pr.search('.rating-stars').attr('title').value
      review_amount = pr.search('.rating-stars__rating-count').text.split('').map {|x| x[/\d+/]}.join.to_i
      available = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[3]/div/text()").text.blank? ? false : true
      availability = html.xpath("//*[@id='js_items_content']/li[#{i+1}]/div[2]/div[3]/div/text()").text.strip

      product = Product.find_or_initialize_by(store_id: store_id)
      product.store_id = store_id if store_id.present?
      product.name = name if name.present?
      product.image = image if image.present?
      product.link = link if link.present?
      product.price = price if price.present?
      product.rating = rating if rating.present?
      product.review_amount = review_amount if review_amount.present?
      product.available = available if available.present?
      product.availability = availability if availability.present?
      product.provider_id = 2

      records << product
    end
    records
  end
end
