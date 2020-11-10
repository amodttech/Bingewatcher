class CreateMovielists < ActiveRecord::Migration[6.0]
  def change
    create_table :movielists do |t|
      t.integer :user_id
    end
  end
end
