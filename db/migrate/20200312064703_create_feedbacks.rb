class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :company_token
      t.integer :number, default: 1
      t.integer :priority, default: 0

      t.timestamps
    end
    add_index :feedbacks, [:company_token, :number], unique: true
  end
end
