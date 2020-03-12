class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :device
      t.string :os
      t.decimal :memory, precision: 10, scale: 2
      t.decimal :storage, precision: 10, scale: 2

      t.timestamps
    end
  end
end
