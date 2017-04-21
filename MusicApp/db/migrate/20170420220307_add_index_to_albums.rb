class AddIndexToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_index :albums, :band_id, unique: true
  end
end
