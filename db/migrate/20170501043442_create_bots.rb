class CreateBots < ActiveRecord::Migration[5.0]
  def change
    create_table :bot_action do |t|
      t.string :user_input
      t.string :bot_response

      t.timestamps
    end
  end
end
