class PostsController < ApplicationController
  before_action :find_post, only: [:like, :unlike, :show, :edit, :update, :destroy]
  before_action :authenticate_user!
	
	def like
		current_user.like!(@post)
		find_post_likes
		respond_to do |format|
			if current_user.likes?(@post)
				format.html {redirect_to root_path }
				format.js { render action: 'like'} 
			end
		end
	end

	def unlike
		current_user.unlike!(@post)
		find_post_likes
		respond_to do |format|
			unless current_user.likes?(@post)
				format.html {redirect_to root_path }
				format.js { render action: 'unlike'} 
			end
		end
	end

	def new
		@post = current_user.posts.build
	end

	def show
		#@comment = Comment.new
	end

	def create
		@post = current_user.posts.build(post_params)

		respond_to do |format|
			if @post.save
				format.html {redirect_to root_path }
				format.js { render action: 'post'} 
			else
				render 'new' 
			end
		end
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body)
	end

	def find_post_likes
		@likes = Like.where("likeable_type = 'Post' AND likeable_id = #{@post.id}").count
	end
end
