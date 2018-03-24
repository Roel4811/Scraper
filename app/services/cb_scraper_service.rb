require 'nokogiri'
require 'open-uri'

class CbScraperService

  def call
    url = "https://www.coolblue.nl/zoeken/producttype:powerbanks/merk:trust?query=powerbanks"
    response = open(url)
    html = Nokogiri::HTML(response)

    products = html.search(".product")
    products.each do |pr, i|
      name = pr.search(".product__title").text.strip
      store_id = pr.css('a')[0]['data-productid'].to_i
      image = pr.css("img").first.attr("src").strip
      link = "/product/#{store_id}"
      price = pr.search(".product__sales-price").text.strip.gsub(",",".").to_f
      rating = pr.search(".review-rating--icons span").first.text.strip
      review_amount = pr.search("span.review-rating--reviews").text.strip.to_i
      available = pr.search(".availability-state").text.strip.include?("uitverkocht") ? false : true
      availability = pr.search(".availability-state").text.strip

      product = Product.find_or_initialize_by(store_id: store_id)
      product.name = name if name.present?
      product.image = image if image.present?
      product.link = link if link.present?
      product.price = price if price.present?
      product.rating = rating if rating.present?
      product.review_amount = review_amount if review_amount.present?
      product.available = available if available.present?
      product.availability = availability if availability.present?

      product.save if product.new_record? || product.changed?
    end
  end
end
