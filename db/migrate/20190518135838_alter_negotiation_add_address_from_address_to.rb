class AlterNegotiationAddAddressFromAddressTo < ActiveRecord::Migration[5.2]
  def change
    remove_column(:negotiations, :country, :string)
    remove_column(:negotiations, :state, :string)
    remove_column(:negotiations, :city, :string)
    remove_column(:negotiations, :street, :string)
    remove_column(:negotiations, :latitude_from, :string)
    remove_column(:negotiations, :longitude_from, :string)
    remove_column(:negotiations, :latitude_to, :string)
    remove_column(:negotiations, :longitude_to, :string)

    change_table(:negotiations) do |t|
      t.json :address_from
      t.json :address_to
    end
  end
end
