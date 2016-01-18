class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :post, counter_cache: true, inverse_of: :comments
end
