class AlterNegotiationAddAddressFromAddressTo < ActiveRecord::Migration[5.2]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/BlockLength
  def change
    reversible do |dir|
      change_table :negotiations, bulk: true do |t|
        dir.up do
          t.json :address_from
          t.json :address_to

          t.remove :country
          t.remove :state
          t.remove :city
          t.remove :street
          t.remove :latitude_from
          t.remove :longitude_from
          t.remove :latitude_to
          t.remove :longitude_to
        end

        dir.down do
          t.remove :address_from
          t.remove :address_to

          t.string :country
          t.string :state
          t.string :city
          t.string :street
          t.string :latitude_from
          t.string :longitude_from
          t.string :latitude_to
          t.string :longitude_to
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/BlockLength
end
