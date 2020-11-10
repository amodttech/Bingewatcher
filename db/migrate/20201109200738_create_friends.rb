class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :user_1_id
      t.integer :user_2_id
    end 
  end
end
