class Search < ApplicationRecord
  has_and_belongs_to_many :providers, uniq: true
  has_and_belongs_to_many :brands, uniq: true

  validates :keywords, no_html: true
  # validates :min_price, no_html: true
  # validates :max_price, no_html: true

  def products
    find_products
  end

  private

  def find_products
    brands = self.brands.map(&:name)
    providers = self.providers.map(&:name)
    keywords = self.keywords.split(" ").map(&:downcase) if keywords.present?

    products = Product.all

    binding.pry
    products = products.products_by_keywords(*keywords) if keywords.present?
    products = products.products_with_providers(*providers) if providers.present?
    products = products.products_with_brands(*brands) if brands.present?
    products = products.products_with_min_price(min_price) if min_price.present?
    products = products.products_with_max_price(max_price) if max_price.present?

    # products = Product.whole_search(keywords, providers, brands, min_price, max_price)
    products
  end

end
