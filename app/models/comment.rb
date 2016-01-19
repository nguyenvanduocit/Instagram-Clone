class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :post, counter_cache: true, inverse_of: :comments
  validates :content, presence: true, allow_nil: false, length: { maximum: 255 }
end
