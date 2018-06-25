class Product < ActiveRecord::Base
  belongs_to :provider

  PRICE_RANGES = ["0-10", "10-20", "20-30", ">30"]

  def provider_name
    self.provider.name if self.provider
  end
end
