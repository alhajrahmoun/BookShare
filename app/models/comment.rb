class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	acts_as_likeable
	validates :body, presence: true
end
