module TasksHelper
  def choose_action_new_or_edit
    if action_name == 'new' || action_name == 'create'
      tasks_path
    else action_name == 'edit' || action_name == 'update'
      task_path
    end
  end
end
