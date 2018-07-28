class Provider < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :name, type: :text, analyzer: :english
    end
  end

  has_many :products
end
