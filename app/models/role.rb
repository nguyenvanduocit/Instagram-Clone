class Role < ActiveRecord::Base
  has_many :users, through: :userroles
  has_many :role_relationships, dependent: :destroy
end
