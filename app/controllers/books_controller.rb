class BooksController < ApplicationController
    before_action :find_book, only: [:follow, :unfollow, :followers, :show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new]

	def follow
		current_user.follow!(@book)

		respond_to do |format|
			if current_user.follows?(@book)
				format.html {redirect_to book_path(@book) }
				format.js { render action: 'follow'} 
			end
	 	end
	end

	def unfollow
		current_user.unfollow!(@book)
		respond_to do |format|
			format.html {redirect_to book_path(@book) }
			format.js { render action: 'unfollow'} 
		end
	end



	def new
		@book = current_user.books.build
	end

	def show
		@authors = @book.authors.map{ |author| [author.first_name,author.last_name].join(" ") }.join(",")

		@reviews = Review.where(book_id: @book.id).order("created_at DESC")
		if @reviews.blank?
		    @avg_review = 0
		else
		    @avg_review = @reviews.average(:rating).round(2)
    	end
	end

	def create
		@book = current_user.books.build(book_params)
		if @book.save
			redirect_to new_book_author_path(@book)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @book.update(book_params)
			redirect_to new_book_author_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to posts_path
	end

	private

	def find_book
		@book = Book.find(params[:id])
		@followers = @book.followers(User).count
	end

	def book_params
		params.require(:book).permit(:title, :description,:ISBN, :community_id, :image)
	end

end
