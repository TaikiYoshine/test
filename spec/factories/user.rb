# frozen_string_literal: true

# frozen_string_literal: true`

FactoryBot.define do
  factory :user do
    id { 105 }
    name { 'old name' }
    email { 'tomboy@gmail.com' }
    birth { '2019/11/11' }
    sex { '男性' }
    hobby { '散歩' }
    job { 'ノージョブ' }
  end
  factory :testuser1, class: User do
    id { 106 }
    name { 'POYO' }
    email { 'yasao@gmail.com' }
    birth { '2019/9/11' }
    sex { '男性' }
    hobby { '缶蹴り' }
    job { 'ノージョブ' }
  end
  factory :testuser2, class: User do
    id { 107 }
    name { 'GAL' }
    email { 'gal@gmail.com' }
    birth { '2015/9/11' }
    sex { '女性' }
    hobby { 'パラパラ' }
    job { 'ギャル' }
  end
end
