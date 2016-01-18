module RolesHelper
  def get_role_by(args)
    Role.find_by(args)
  end
end
