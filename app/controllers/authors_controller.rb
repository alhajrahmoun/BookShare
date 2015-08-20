class AuthorsController < ApplicationController

	def new
		@book = Book.find(params[:book_id])
	end

	def create
		@book = Book.find(params[:book_id])
		@book.authors << Author.find_or_create_by(author_params)
		redirect_to book_path(@book)
	end

	private

	def author_params
		params.require(:author).permit(:first_name, :last_name)
	end
end
