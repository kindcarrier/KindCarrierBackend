class RemoveDeal < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :deal_id, :integer
    add_reference :messages, :negotiation, index: true
    drop_table :deals
  end
end
