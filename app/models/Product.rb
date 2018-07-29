class Product < ActiveRecord::Base
  searchkick

  belongs_to :provider

  def provider_name
    self.provider.name if self.provider
  end

  def self.present_brands
    Product.distinct.pluck(:brand).select(&:present?)
  end

  def self.whole_search(keywords, min_price, max_price)
    keywords = "*" unless keywords.present?
    min_price = 0 unless min_price.present?
    max_price = 1000 unless max_price.present?

    self.search(keywords, where: {
        price: min_price..max_price
      }, operator: "or", load: false)
  end

  def self.search_brands(brand)
    self.search(brand, load: false)
  end

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :name, :price, :image, :link, :rating, :review_amount, :store_id, :available, :availability, :provider_id, :brand, :issue],
      include: {
        provider: {
          only: :name
        }
      }
    )
  end
end
