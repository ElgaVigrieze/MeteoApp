class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.references :station, null: false, foreign_key: true
      t.references :parameter, null: false, foreign_key: true
      t.timestamp :time
      t.decimal :value

      t.timestamps
    end
  end
end
