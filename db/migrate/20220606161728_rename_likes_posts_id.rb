class RenameLikesPostsId < ActiveRecord::Migration[7.0]
  def change
    change_table :likes do |t|
      t.rename :posts_id, :post_id
    end
  end
end
