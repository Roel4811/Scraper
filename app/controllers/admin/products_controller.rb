class Admin::ProductsController < Admin::ApplicationController

  def create_products
    params[:products].each do |product|
      if params[:save_to_db_ids].include?(product[:store_id])
        Product.create!(product_params(product))
      end
    end
    redirect_to admin_root_path
  end

  private

  def product_params(params)
    params.permit(:name, :store_id, :image, :link, :price, :rating, :review_amount, :available, :availability, :provider_id)
  end
end
