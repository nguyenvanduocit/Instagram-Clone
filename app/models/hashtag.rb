class Hashtag < ActiveRecord::Base
  has_many :posts, through: :hashtag_relationships
  has_many :hashtag_relationships
  before_save { self.name.downcase! }
end
