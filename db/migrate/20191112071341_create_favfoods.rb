# frozen_string_literal: true

class CreateFavfoods < ActiveRecord::Migration[6.0]
  def change
    create_table :favfoods do |t|
      t.text :favorite_food
      t.integer :user_id

      t.timestamps
    end
  end
end
