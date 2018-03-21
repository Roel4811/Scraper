require 'nokogiri'
require 'open-uri'

class BolScraperService

  def call
    url = "https://www.bol.com/nl/l/anker-powerbanks/N/18135/filter_N/4294856588/?view=tiles"
    response = open(url)
    html = Nokogiri::HTML(response)

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
      product.name = name if name.present?
      product.image = image if image.present?
      product.link = link if link.present?
      product.price = price if price.pr
      product.rating = rating if rating.present?
      product.review_amount = review_amount if review_amount.present?
      product.available = available if available.present?
      product.availability = availability if availability.present?

      binding.pry
      product.save if product.new_record? || product.changed?
    end
  end
end


# url
# https://www.bol.com/nl/l/elektronica/powerbanks/N/18135/suggestionType/category/suggestedFor/powerbank/originalSearchContext/media_all/originalSection/main/index.html?_requestid=1015069
# powerbanks = /N/18135
# anker = 4280701110
# samsung = 4294937500
# xiaomi = 4282619856
# trust = 4294856588
