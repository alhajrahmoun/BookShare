class Community < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :books
	acts_as_followable
	
	has_attached_file :image, :styles => { :medium => "177x249", :thumb => "100x100" }, :default_url => "book.png"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
