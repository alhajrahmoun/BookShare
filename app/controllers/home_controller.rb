class HomeController < ApplicationController
	before_action :signed_in, only: [:index]
	before_action :find_user, only: [:index, :show, :edit, :update, :destroy]

	  def index	
		@posts = Post.where("user_id IN (?)",@followees_ids).order("created_at DESC")

		@reviews = Review.where("user_id IN (?)",@followees_ids).order("created_at DESC")
		@book_follow = Follow.where("follower_id IN (?) AND followable_type = ?",@followees_ids,"Book").order("created_at DESC").limit(3)
		@user_follow = Follow.where("follower_id IN (?) AND followable_type = ?",@followees_ids,"User").order("created_at DESC").limit(3)
		@activity = (@book_follow + @user_follow).sort{|a,b| a.created_at <=> b.created_at}
		@last_follow = @activity.last
		@last_review = @reviews.first
	  end

	  protected

	def find_user
		@user = User.find(current_user.id)
		find_followees
	end

	def find_followees
		@followees = Follow.where("follower_id = #{current_user.id} AND followable_type = 'User'")
		@followees_ids = @followees.pluck(:followable_id)
		@followees_ids << current_user.id
	end

	def signed_in
		unless user_signed_in?
	  		redirect_to '/welcome'
	  	end
	end
end
