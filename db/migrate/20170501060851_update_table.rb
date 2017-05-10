class UpdateTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :bot_action, :bot_actions
  end
end
