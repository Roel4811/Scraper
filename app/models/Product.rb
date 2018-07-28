class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :name, type: :text, analyzer: :english
      indexes :price, type: :integer
      indexes :image, type: :text
      indexes :link, type: :text
      indexes :rating, type: :text
      indexes :review_amount, type: :integer
      indexes :store_id, type: :keyword
      indexes :available, type: :boolean
      indexes :availability, type: :text, analyzer: :english
      indexes :provider_id, type: :integer
      indexes :brand, type: :text, analyzer: :english
      indexes :issue, type: :boolean
    end
  end

  belongs_to :provider

  PRICE_RANGES = ["0-10", "10-20", "20-30", ">30"]

  def provider_name
    self.provider.name if self.provider
  end

  def self.present_brands
    Product.distinct.pluck(:brand).select(&:present?)
  end

  def self.search_products(query)
    self.search({
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
