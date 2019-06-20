class RemoveDeal < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :deal_id, :integer
    add_reference :messages, :negotiation, index: true
    drop_table :deals do |t|
      t.integer :negotiation_ids, array: true
      t.string :photo
      t.string :description
      t.decimal :supplying_cost, default: 0, null: false
      t.boolean :is_confirmed, default: false, null: false
      t.timestamps
    end
  end
end
