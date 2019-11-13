# frozen_string_literal: true

json.extract! favfood, :id, :favorite_food, :user_id, :created_at, :updated_at
json.url favfood_url(favfood, format: :json)
