require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @post = @user.posts.build(content: "Lorem ipsum")
  end
  test "Test post must valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 155 characters" do
    @post.content = "a" * 256
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "must add, remove hashtag" do
    @post.save
    @post.add_hashtag("new_hash_tag")
    assert @post.has_hashtag("new_hash_tag")

    @post.remove_hashtag("new_hash_tag")
    assert_not @post.has_hashtag("new_hash_tag")

  end

  test "add comment" do
    @post.comments.build(content: "Comment", user_id: @user.id)

  end

end
