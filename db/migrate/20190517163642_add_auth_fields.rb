class AddAuthFields < ActiveRecord::Migration[5.2]
  def up
    change_table(:users, bulk: true) do |t|
      t.column :salt, :string
      t.column :token, :string
    end
  end

  def down
    change_table(:users, bulk: true) do |t|
      t.remove :salt
      t.remove :token
    end
  end
end
