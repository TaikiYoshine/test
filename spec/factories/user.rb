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
end
