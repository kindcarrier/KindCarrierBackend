class CreateNegotiation < ActiveRecord::Migration[5.2]
  def change
    create_table :negotiations do |t|
      t.string :name, null: false
      t.string :photo
      t.string :description, null: false
      t.decimal :service_cost, default: 0, null: false
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.float :latitude_from
      t.float :longitude_from
      t.float :latitude_to
      t.float :longitude_to
      t.integer :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
