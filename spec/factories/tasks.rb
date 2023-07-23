FactoryBot.define do
  factory :task do
    name {'test_name'}
    content {'test_content'}
    status {'未着手'}
    priority {'低'}
    user {'user_name1'}
  end
  factory :second_task, class: Task do
    name {'Factoryで作ったデフォルトのタスク2'}
    content {'Factoryで作ったデフォルトのコンテント2'}
    status {'着手中'}
    priority {'高'}
    user {'user_name1'}
  end
  factory :third_task, class: Task do
    name {'Factoryで作ったデフォルトのタスク3'}
    content {'Factoryで作ったデフォルトのコンテント3'}
    status {'完了'}
    priority {'中'}
    user {'user_name1'}
  end
end
