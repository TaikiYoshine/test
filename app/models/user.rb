# frozen_string_literal: true

class User < ApplicationRecord
  has_many :microposts
  # 各カラムの存在性
  validates :name, presence: true
  validates :email, presence: true
  validates :sex, presence: true
  validates :birth, presence: true
  validates :hobby, presence: true
  validates :job, presence: true
  # メアドのフォーマットバリデ
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
