class Product < ActiveRecord::Base
  belongs_to :provider

  def provider_name
    self.provider.name if self.provider
  end
end
