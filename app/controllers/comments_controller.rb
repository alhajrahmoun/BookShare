class CommentsController < ApplicationController
	before_action :find_comment, only: [:like, :unlike]

	def like
		current_user.like!(@comment)
		find_comment_likes
		respond_to do |format|
			if current_user.likes?(@comment)
				format.html {redirect_to root_path }
				format.js { render action: 'like'} 
			end
		end
	end

	def unlike
		current_user.unlike!(@comment)
		find_comment_likes
		respond_to do |format|
			unless current_user.likes?(@comment)
				format.html {redirect_to root_path }
				format.js { render action: 'unlike'} 
			end
		end
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:body))
		@comment.user_id = current_user.id if current_user
		find_post_likes
		respond_to do |format|
			if @comment.save
				format.html {redirect_to root_path }
				format.js {}
			else
				render 'new'
			end
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to root_path
	end

	private

	def find_comment
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def find_comment_likes
		@likes = Like.where("likeable_type = 'Comment' AND likeable_id = #{@comment.id}").count
	end

	def find_post_likes
		@likes = Like.where("likeable_type = 'Post' AND likeable_id = #{@post.id}").count
	end
end
