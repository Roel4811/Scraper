class Product < ActiveRecord::Base
  searchkick word_start: [:name]
  scope :search_import, -> { includes(:provider) }

  belongs_to :provider

  def search_data
    {
      name: name,
      provider: provider.name,
      brand: brand
    }
  end

  def provider_name
    self.provider.name if self.provider
  end

  def self.present_brands
    Product.distinct.pluck(:brand).select(&:present?)
  end

  def self.whole_search(providers, brands, min_price, max_price)
    keywords = "*" unless keywords.present?
    providers = "" unless providers.present?
    brands = "" unless brands.present?
    min_price = 0 unless min_price.present?
    max_price = 1000 unless max_price.present?

    products_by_keywords = Product.search(keywords, operator: "or", execute: false)
    products_by_providers = Product.search(providers, operator: "or", execute: false)
    products_by_brand = Product.search(brands, operator: "or", execute: false)

    binding.pry

    Searchkick.multi_search([products_by_keywords, products_by_providers, products_by_brand], where: {
        price: min_price..max_price
      }, operator: "or", load: false)
  end

  def self.search_brands(brand)
    self.search(brand, load: false)
  end

  def self.search_providers(provider)
    self.search(provider, fields: [:provider], load: false)
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
