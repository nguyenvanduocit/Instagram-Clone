# default role
Role.delete_all
default_roles = {}
[
    {name: 'administrator', title: 'Administrator'},
    {name: 'member', title: 'Member'}
].each do |role|
  default_roles[role[:name]] = Role.create!(role)
end

User.delete_all

default_admin = User.create!(user_name: "nguyenvanduocit",
             email: "nguyenvanduocit@gmail.com",
             password: "password",
             password_confirmation: "password")

default_admin.add_role(default_roles['administrator'])

#test data

99.times do |n|
  user_name = 'username' + n.to_s
  email = n.to_s.concat(Faker::Internet.email)
  password = "password"
  user = User.create!(user_name: user_name,
               email: email,
               password: password,
               password_confirmation: password)
  user.add_role(default_roles['member'])
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }