class CreateMovielists < ActiveRecord::Migration[5.2]
  def change
    create_table :movielists do |t|
      t.integer :user_id
    end
  end
end
