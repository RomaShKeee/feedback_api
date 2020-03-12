class AddFeedbackIdToState < ActiveRecord::Migration[5.2]
  def change
    add_reference :states, :feedback, foreign_key: true
  end
end
