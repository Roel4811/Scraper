class Brand < ApplicationRecord
  has_many :products
  has_and_belongs_to_many :searches
end
