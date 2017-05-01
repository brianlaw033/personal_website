class AddImg < ActiveRecord::Migration[5.0]
  def change
    add_column(:blogs, :image, :string)
  end
end
