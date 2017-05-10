class Blog < ApplicationRecord
  searchkick
  has_attached_file :image
  has_many :comments, :as => :commentable
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
