require 'test_helper'

class RoleRelationshipTest < ActiveSupport::TestCase
  test "should add role success" do
    user = users(:michael)
    admin_role = roles(:admin)
    member_role = roles(:member)

    user.add_role(admin_role)
    user.add_role(member_role)

    assert user.has_role?(admin_role)

    user.remove_role(admin_role)
    assert_not user.has_role?(admin_role)

    assert user.has_role?(member_role)
  end
end
