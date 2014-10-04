class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title

      t.timestamps
    end
    add_index :photos, :title
  end
end
