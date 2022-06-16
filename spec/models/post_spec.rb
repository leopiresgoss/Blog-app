require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) do
    user = User.create(name: 'Maria', email: 'maria@email.com', password: 'password', photo: '',
                       bio: 'Teacher from Brazil.', confirmed_at: Time.now)
    Post.new(author: user, title: 'Hello 1', text: 'This is my first post')
  end

  before { post.save }

  describe 'validations' do
    it 'does not validate without an author' do
      post.author = nil
      expect(post).to_not be_valid
    end

    it 'does not validate without a title' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'does not validate when a title is blank' do
      post.title = ''
      expect(post).to_not be_valid
    end

    it 'does not validate when a title exceeds 250char' do
      post.title = 'kkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                      kkkkkkkkkkkkkkkkkkk'

      expect(post).to_not be_valid
    end

    it 'does not validate without a text' do
      post.text = nil
      expect(post).to_not be_valid
    end

    it 'does not validate if likes_counter is not >= 0' do
      post.likes_counter = -5
      expect(post).to_not be_valid
    end

    it 'does not validate if comments_counter is not >= 0' do
      post.comments_counter = -5
      expect(post).to_not be_valid
    end
  end

  describe '#five_recent_comments' do
    subject(:five_recent_comments) do
      user = post.author
      post.comments.create(text: '1', author: user)
      post.comments.create(text: '2', author: user)
      post.comments.create(text: '3', author: user)
      post.comments.create(text: '4', author: user)
      post.comments.create(text: '5', author: user)
      post.comments.create(text: '6', author: user)
      post.comments.create(text: '7', author: user)
      post.comments.create(text: '8', author: user)
      post.five_recent_comments
    end

    it 'should return an array of comments' do
      expect(five_recent_comments).to all(be_instance_of(Comment))
    end

    it 'should return the last five recent comments for a post' do
      expect(five_recent_comments.length).to eq(5)
    end

    it 'should not return the 1th comment' do
      expect(five_recent_comments).not_to include(id: 1)
    end
  end

  describe '#increment_user_posts_counter' do
    it 'increment the posts_counter by one' do
      user = post.author
      prev_posts_counter = user.posts_counter

      Post.create(author: user, title: 'title', text: 'text')

      expect(user.posts_counter).to eq(prev_posts_counter + 1)
    end
  end

  describe '#decrement_user_posts_counter' do
    it 'decrement the posts_counter by one' do
      author = post.author
      post.destroy
      expect(author.posts_counter).to eq(0)
    end
  end
end
