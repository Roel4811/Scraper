class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  prepend_view_path Rails.root.join("app/frontend")

  def about
    @providers = Provider.all
    @products = Product.order(:name)
    @all_products = @products
    @brands = Brand.all
    @search = Search.new

    respond_to do |format|
      format.html
      format.js {
        render 'about'
      }
    end
  end

  def contact
    @providers = Provider.all
    @products = Product.order(:name)
    @all_products = @products
    @brands = Brand.all
    @search = Search.new
    @contact_submission = ContactSubmission.new

    respond_to do |format|
      format.html
      format.js {
        render 'contact'
      }
    end
  end

  def create_contact_submission
    @contact_submission = ContactSubmission.create(contact_submission_params)

    if @contact_submission.persisted?
      render 'contact_submission_success'
    else
      render 'something_went_wrong'
    end
  end

  private

  def contact_submission_params
    params.require(:contact_submission).permit(:name, :email, :message)
  end
end
