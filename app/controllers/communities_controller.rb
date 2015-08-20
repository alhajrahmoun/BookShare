class CommunitiesController < ApplicationController
	before_action :find_community, only: [:follow, :unfollow, :followers, :show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new]

	def follow
		current_user.follow!(@community)
		respond_to do |format|
			if current_user.follows?(@community)
				format.html {redirect_to root_path }
				format.js { render action: 'follow'} 
			end
	 	end
	end

	def unfollow
		current_user.unfollow!(@community)
		respond_to do |format|
			format.html {redirect_to root_path }
			format.js { render action: 'unfollow'} 
		end
	end

	def followers
		@followers = @community.followers(User)
	end

	def index
		@communities = Community.all
	end

	def show
		@books = Book.where("community_id = #{@community.id}").order("created_at DESC")
	end

	def new
		@community = Community.new
	end

	def create
		@community.new(community_params)
		if @community.save
			redirect_to @community
		else
			render 'new'
		end
	end


	def update
		if @community.update(params[:community].permit(:title,:description))
			redirect_to @community
		else
			render 'edit'
		end
	end

	def destroy
		@community.destroy

		redirect_to communities_path
	end


	protected

	def find_community
		@community = Community.find(params[:id])
		@followers = @community.followers(User).count
	end

	def community_params
		params.require(:community).permit(:title,:description)
	end
end
