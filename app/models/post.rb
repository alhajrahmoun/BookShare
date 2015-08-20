class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :body, presence: true
	acts_as_likeable
end
