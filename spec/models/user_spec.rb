require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.create(name: 'Maria', email: 'maria@email.com', password: 'password', photo: '', bio: 'Teacher from Brazil.',
                confirmed_at: Time.now)
  end

  before { user.save }

  describe 'validations' do
    it 'does not validate without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'does not validate if posts_counter is not >= 0' do
      user.posts_counter = -5
      expect(user).to_not be_valid
    end
  end

  describe '#tree_recent_posts' do
    subject(:tree_recent_posts) do
      Post.create(author: user, title: 'Hello 1', text: 'This is my first post')
      Post.create(author: user, title: 'Hello 2', text: 'This is my second post')
      Post.create(author: user, title: 'Hello 3', text: 'This is my third post')
      Post.create(author: user, title: 'Hello 4', text: 'This is my fourth post')
      user.tree_recent_posts
    end

    it 'should be an instance of Post' do
      expect(tree_recent_posts).to all(be_instance_of(Post))
    end

    it 'should return the last three recent posts for a user that has 4 posts' do
      expect(tree_recent_posts.length).to eq(3)
    end
  end
end
