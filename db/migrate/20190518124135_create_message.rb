class CreateMessage < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.references :user, foreign_key: true
      t.references :deal, foreign_key: true

      t.timestamps
    end
  end
end
