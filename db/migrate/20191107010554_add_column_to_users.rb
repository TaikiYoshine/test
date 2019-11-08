# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sex, :string
    add_column :users, :birth, :date
    add_column :users, :hobby, :string
    add_column :users, :job, :string
  end
end
