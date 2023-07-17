FactoryBot.define do
  factory :task do
    name {'test_name'}
    content {'test_content'}
    status {'未着手'}
  end
  factory :second_task, class: Task do
    name {'Factoryで作ったデフォルトのタスク2'}
    content {'Factoryで作ったデフォルトのコンテント2'}
    status {'着手中'}
  end
  factory :third_task, class: Task do
    name {'Factoryで作ったデフォルトのタスク3'}
    content {'Factoryで作ったデフォルトのコンテント3'}
    status {'完了'}
  end
end
