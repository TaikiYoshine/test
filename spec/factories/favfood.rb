# frozen_string_literal: true

# frozen_string_literal: true`

FactoryBot.define do
  factory :favfood do
    user
    id { 1 }
    favorite_food { 'old food' }
    user_id { 105 }
  end
  factory :testfood1, class: Favfood do
    user
    id { 2 }
    favorite_food { 'test food1' }
    user_id { 106 }
  end
end
