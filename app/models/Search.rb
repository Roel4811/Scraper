class Search < ApplicationRecord

  before_save :remove_brackets, :remove_commas

  def remove_brackets
    self.brands.gsub!(/[\[\]\"]/, "") if attribute_present?("brands")
  end

  def remove_commas
    self.brands.gsub!(/\,/,"") if attribute_present?("brands")
  end

  def products
    @products ||= find_products
  end

  private

  def find_products
    products = Product.order(:name)
    # products = products.where("name like ?", "%#{keywords}%") if keywords.present?
    # products = products.where(category_id: category_id) if category_id.present?
    # products = products.where("price >= ?", min_price) if min_price.present?
    # products = products.where("price <= ?", max_price) if max_price.present?
    # binding.pry
    products = products.whole_search(brands, min_price, max_price)
    # products = products.search_on_keywords(brands).records if brands.present?
    # products = products.search_on_price_range(min_price, max_price) if (min_price.present? && max_price.present?)
    products
  end

end
