class Book < ActiveRecord::Base
	has_many :users, through: :reviews
    has_many :reviews
    belongs_to :community
    has_and_belongs_to_many :authors
	acts_as_followable

    has_attached_file :image, :styles => { :medium => "177x249", :thumb => "100x100" }, :default_url => "book.png"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    validates :title, :description, :ISBN, :community_id, presence: true
    validates :title, :ISBN, uniqueness: true
end
