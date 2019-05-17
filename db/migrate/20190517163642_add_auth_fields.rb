# frozen_string_literal: true

class AddAuthFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :salt, :string
    add_column :users, :token, :string
  end
end
