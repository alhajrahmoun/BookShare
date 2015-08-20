class UsersController < ApplicationController
    before_action :find_user, only: [:follow, :unfollow, :followers, :show, :edit, :update, :destroy]
	before_action :authenticate_user!
	
	def follow
		current_user.follow!(@user)
		if current_user.follows?(@user)
			redirect_to @user
		else
			render 'index'
		end
	end

	def unfollow
		current_user.unfollow!(@user)
		redirect_to @user
	end

	def show
		dob = @user.birthday
		age(dob)

		@posts = Post.where("user_id = #{@user.id}").order("created_at DESC")
		@book_follow = Follow.where("follower_id = #{@user.id} AND followable_type= 'Book'").order("created_at DESC").limit(3)
		@user_follow = Follow.where("follower_id = #{@user.id} AND followable_type= 'User'").order("created_at DESC").limit(3)
		@reviews = Review.where("user_id = #{@user.id}").order("created_at DESC").limit(3)
		@activity = (@book_follow + @user_follow).sort{|a,b| a.created_at <=> b.created_at}
		@activity.reverse!
	end

	protected

	def find_user
		@user = User.find(params[:id])
		@followees = @user.followees(User)
		@followers = @user.followers(User)
		@followers_count = @user.followers(User).count
	end

	def age(dob)
		now = Time.now.to_date
		@age = now.year - dob.year
	end
end
