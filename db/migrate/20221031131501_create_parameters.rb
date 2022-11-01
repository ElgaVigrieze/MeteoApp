class CreateParameters < ActiveRecord::Migration[6.1]
  def change
    create_table :parameters do |t|
      t.string :name
      t.string :measuring_unit

      t.timestamps
    end
  end
end
