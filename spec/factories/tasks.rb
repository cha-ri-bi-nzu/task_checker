FactoryBot.define do
  factory :task do
    name {'test_name'}
    content {'test_content'}
  end
  # factory :second_task, class: Task do
  #   name {'Factoryで作ったデフォルトのタスク2'}
  #   content {'Factoryで作ったデフォルトのコンテント2'}
  # end
end
