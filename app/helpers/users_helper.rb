module UsersHelper
  def choose_action_new_or_edit
    if action_name == 'new' || action_name == 'create'
      users_path
    else action_name == 'edit' || action_name == 'update'
      user_path
    end
  end
end
