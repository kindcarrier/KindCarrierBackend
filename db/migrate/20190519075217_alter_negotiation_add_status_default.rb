class AlterNegotiationAddStatusDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :negotiations, :status, :integer, default: 0, null: false
  end
end
