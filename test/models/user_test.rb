require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_name: "sampleuse", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "user name must valid" do
    @user.user_name = "Duoc nguyen va"
    assert_not @user.valid?
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer  = users(:archer)

    assert_not michael.following?(archer)
    michael.follow(archer)

    assert michael.following?(archer)

    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "should follow and unfollow a user passive" do
    michael  = users(:michael)
    archer   = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    assert archer.followed_by?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

end
