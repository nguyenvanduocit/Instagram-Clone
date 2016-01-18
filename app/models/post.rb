class Post < ActiveRecord::Base
  #has_many :comments, inverse_of: :post
  has_many :hashtags, through: :hashtag_relationships
  has_many :hashtag_relationships
  belongs_to :user, inverse_of: :posts
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) } #take care : http://stackoverflow.com/questions/25087336/why-is-using-the-rails-default-scope-often-recommend-against
  validates :user_id, presence: true
  validates :content, presence: true, allow_nil: false, length: { maximum: 255 }
  validate  :picture_size

  def add_hashtag(hashtag)
    if hashtag.is_a? Hashtag
      found_hashtag = args
    else
      found_hashtag = Hashtag.find_by(name: hashtag)
    end

    if found_hashtag
      hashtag_relationships.create!(hashtag_id: found_hashtag.id)
    else
      hashtags.create(name: hashtag)
    end
  end

  def remove_hashtag(hashtag)
    if hashtag.is_a? Hashtag
      hashtag_id = hashtag.id
    else
      found_hashtag = Hashtag.find_by(name: hashtag)
      hashtag_id = found_hashtag.id
    end
    hashtag_relationships.find_by(hashtag_id: hashtag_id).destroy if hashtag_id
  end

  def has_hashtag(hashtag)
    if hashtag.is_a? Hashtag
      hashtags.include?(hashtag)
    else
      hashtags.find_by(name: hashtag)
    end
  end
  private
  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
