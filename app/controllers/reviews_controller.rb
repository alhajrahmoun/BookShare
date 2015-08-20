class ReviewsController < ApplicationController
   before_action :find_review, only: [:like,:unlike,:show, :edit, :update, :destroy]
   before_action :find_book
   before_action :authenticate_user!

  def like
    current_user.like!(@review)
    find_review_likes
    respond_to do |format|
      if current_user.likes?(@review)
        format.html {redirect_to root_path }
        format.js { render action: 'like'} 
      end
    end
  end

  def unlike
    current_user.unlike!(@review)
    find_review_likes
    respond_to do |format|
      unless current_user.likes?(@review)
        format.html {redirect_to root_path }
        format.js { render action: 'like'} 
      end
    end
  end

  def new
    #@review = Review.new
  end

  def create
  	@review = Review.new(review_params)
  	@review.user_id = current_user.id
  	@review.book_id = @book.id

    respond_to do |format|
      if @review.save
        format.html {redirect_to root_path }
        format.js {}
      else
        render @book
      end
    end
  end

  private
    def find_review
      @review = Review.find(params[:id])
    end

    def find_book
      @book = Book.find(params[:book_id])
    end

    def find_review_likes
      @likes = Like.where("likeable_type = 'Review' AND likeable_id = #{@review.id}").count
    end

    def review_params
      params.require(:review).permit(:rating, :body)
    end
end
