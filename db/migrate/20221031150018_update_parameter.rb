class UpdateParameter < ActiveRecord::Migration[6.1]
  def change
    add_column(:parameters, :code, :string)
  end
end