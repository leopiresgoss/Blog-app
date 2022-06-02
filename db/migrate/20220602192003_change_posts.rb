class ChangePosts < ActiveRecord::Migration[7.0]
  change_table :posts do |t|
    t.rename :users_id, :author_id
  end
end
