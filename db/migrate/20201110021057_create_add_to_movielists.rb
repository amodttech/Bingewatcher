class CreateAddToMovielists < ActiveRecord::Migration[6.0]
  def change
    create_table :Addmovietomovielists do |t|
      t.integer :movie_id
      t.integer :movielist_id
      t.integer :priority
    end
  end
end
