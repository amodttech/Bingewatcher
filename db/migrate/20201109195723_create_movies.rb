class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.integer :year
      t.string :genre
      t.string :country
      t.string :synopsis
    end
  end
end
