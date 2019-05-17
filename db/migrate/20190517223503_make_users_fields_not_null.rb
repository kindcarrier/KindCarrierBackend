class MakeUsersFieldsNotNull < ActiveRecord::Migration[5.2]
  def up
    change_table(:users, bulk: true) do |t|
      t.change :first_name, :string, null: false
      t.change :last_name, :string, null: false
      t.change :email, :string, null: false
      t.change :crypted_password, :string, null: false
      t.change :token, :string, null: false

      t.index :email, unique: true
    end
  end

  def down
    change_table(:users, bulk: true) do |t|
      t.change :first_name, :string, null: true
      t.change :last_name, :string, null: true
      t.change :email, :string, null: true
      t.change :crypted_password, :string, null: true
      t.change :token, :string, null: true

      t.remove_index :email
    end
  end
end
