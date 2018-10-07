class Product < ActiveRecord::Base
  # searchkick word_middle: [:name]
  # scope :search_import, -> { includes(:provider) }

  belongs_to :provider
  belongs_to :brand

  scope :search_by_keywords, -> (*keywords) { binding.pry }

  scope :products_by_keywords, -> (*keywords) { where((["lower(products.name) like ?"] * keywords.size).join(' OR '), *keywords.map { |keyword| "%#{keyword}%" }) }
  scope :products_with_providers, -> (*providers) { joins(:provider).where((["lower(providers.name) like ?"] * providers.size).join(' OR '), *providers.map { |provider| "%#{provider}%" }) }
  scope :products_with_brands, -> (*brands) { joins(:brand).where((["lower(brands.name) like ?"] * brands.size).join(' OR '), *brands.map { |brand| "%#{brand}%" }) }
  scope :products_with_min_price, -> (min_price) { where("products.price >= ?", min_price) }
  scope :products_with_max_price, -> (max_price) { where("products.price <= ?", max_price) }

  def search_data
    {
      name: name,
      provider: provider.name,
      brand: brand,
      price: price
    }
  end

  def provider_name
    self.provider.name if self.provider
  end

  def brand_name
    self.brand.name if self.brand
  end

  def self.whole_search(keywords, providers, brands, min_price, max_price)
    keywords = "*" unless keywords.present?
    providers = "*" unless providers.present?
    brands = "*" unless brands.present?
    min_price = 0 unless min_price.present?
    max_price = 1000 unless max_price.present?

    products = Product.search(keywords, where: {price: {gt: min_price, lt: max_price}}).results &
    Product.search(providers, fields: [:provider], operator: "or").results &
    Product.search(brands, operator: "or").results

    products
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
