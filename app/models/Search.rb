class Search < ApplicationRecord

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
    products = products.search_products(brands.join(" ")) if brands.present?
    products
  end

  def self.search_products(query)
    Product.search({
      from: 0,
      size: 40,
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: query,
              fields: [:name, :availability, :brand]
            }
          },
          {
            match: {
              available: true
            }
          }]
        }
      },
      highlight: {
        pre_tags: ['<em><strong>'],
        post_tags: ['</em></strong>'],
        fields: {
          name: {}
        }
      }
    })
  end

end
