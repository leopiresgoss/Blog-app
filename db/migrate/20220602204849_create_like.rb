class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.timestamps
      t.references :users, null: false, foreign_key: true
      t.references :posts, null: false, foreign_key: true
    end
  end
end
