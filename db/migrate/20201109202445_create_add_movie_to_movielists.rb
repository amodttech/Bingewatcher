class CreateAddMovieToMovielists < ActiveRecord::Migration[5.2]
  def change
    create_table :Addmovietomovielists do |t|
      t.integer :movie_id
      t.integer :movielist_id
      t.integer :priority
    end
  end
end
