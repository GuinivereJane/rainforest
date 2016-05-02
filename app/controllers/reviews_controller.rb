class ReviewsController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:show]

  before_action :load_product


  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    respond_to do |format|
            format.js {} # This will look for app/views/reviews/create.js.erb
    end

  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user
    @review.save
          respond_to do |format|
                  format.js {} # This will look for app/views/reviews/create.js.erb
          end


end

  def edit
    @review = Review.find(params[:id])
    @product = Product.find(params[:product_id])
    respond_to do |format|
            format.js {} # This will look for app/views/reviews/create.js.erb
    end
  end

  def update
    @review = Review.find(params[:id])
    @product = Product.find(params[:product_id])
    @review.update_attributes(review_params)
    respond_to do |format|
            format.js {} # This will look for app/views/reviews/create.js.erb
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_url(@product)
  end

  private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end
end
