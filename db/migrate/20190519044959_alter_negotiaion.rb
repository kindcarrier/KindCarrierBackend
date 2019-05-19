class AlterNegotiaion < ActiveRecord::Migration[5.2]
  def change
    add_column :negotiations, :status, :integer
    remove_column :negotiations, :user_id, :int
    add_reference :negotiations, :owner
    add_reference :negotiations, :accepter
  end
end
