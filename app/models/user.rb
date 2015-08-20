class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :books, through: :reviews
  has_many :reviews
  has_and_belongs_to_many :communities
  acts_as_follower
  acts_as_followable
  acts_as_liker

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "missing.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
