# frozen_string_literal: true

class Favfood < ApplicationRecord
  belongs_to :user
  validates :favorite_food, presence: true
end
