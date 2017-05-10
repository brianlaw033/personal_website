class AddImagesToBlogs < ActiveRecord::Migration[5.0]
  def change
    change_table :blogs do |t|
      t.attachment :image
    end
  end
end
