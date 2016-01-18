class User < ActiveRecord::Base
  has_many :posts, inverse_of: :user, dependent: :destroy
  #has_many :comments, inverse_of: :user, dependent: :destroy
  has_many :role_relationships, dependent: :destroy
  has_many :roles, through: :role_relationships

  has_many :following_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token

  before_save {
    self.email.downcase!
    self.user_name.downcase!
  }
  has_secure_password
  validates :user_name, presence: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }, length: { minimum: 5, maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Post.where("user_id = ?", id)
  end

  def remember
    self.remember_token = User.generate_remember_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def remember_token_valid?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def add_role(role)
    role_relationships.create(role_id: role.id)
  end

  def remove_role(role)
    role_relationships.find_by(role_id: role.id).destroy
  end

  def has_role?(role)
    roles.include?(role)
  end

  def follow(followed_user)
    following_relationships.create(followed_id: followed_user.id)
  end

  def unfollow(followed_user)
    following_relationships.find_by(followed_id: followed_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(followed_user)
    following.include?(followed_user)
  end

  def followed_by?(following_user)
    followers.include?(following_user)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.generate_remember_token
    SecureRandom.urlsafe_base64
  end

end
