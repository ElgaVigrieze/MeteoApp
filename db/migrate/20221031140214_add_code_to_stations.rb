class AddCodeToStations < ActiveRecord::Migration[6.1]
  def change
    add_column(:stations, :code, :string)
  end
end
