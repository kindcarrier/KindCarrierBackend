class AlterNegotiaion < ActiveRecord::Migration[5.2]
  def change
    change_table :negotiations, bulk: true do |t|
      t.integer :status

      t.references :owner
      t.references :accepter
    end
    remove_column :negotiations, :user_id, :int
  end
end
