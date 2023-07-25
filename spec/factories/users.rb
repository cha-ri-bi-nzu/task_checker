FactoryBot.define do
  factory :user do
    name {'user_name1'}
    email {'1ban@mail.com'}
    password {'aaaaaa'}
    admin {'管理者'}
  end
  factory :second_user, class: User do
    name {'user_name2'}
    email {'2ban@mail.com'}
    password {'bbbbbb'}
    admin {'一般'}
  end
  factory :third_user, class: User do
    name {'iltsupan_user'}
    email {'iltsupan@mail.com'}
    password {'cccccc'}
    admin {'一般'}
  end
  factory :fourth_user, class: User do
    name {'admin_user'}
    email {'admin@mail.com'}
    password {'dddddd'}
    admin {'管理者'}
  end
end
