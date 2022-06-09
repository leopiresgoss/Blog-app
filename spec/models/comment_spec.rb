require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) do
    user = User.create(name: 'Maria', photo: '', bio: 'Teacher from Brazil.')
    post = Post.create(author: user, title: 'Hello 1 (Tom)', text: 'This is my first post')
    Comment.new(author: user, post:, text: 'hey')
  end

  before { comment.save }

  describe 'validations' do
    it 'does not validate without an author' do
      comment.author = nil
      expect(comment).to_not be_valid
    end

    it 'does not validate without an author' do
      comment.post = nil
      expect(comment).to_not be_valid
    end

    it 'does not validate without a text' do
      comment.text = nil
      expect(comment).to_not be_valid
    end
  end

  describe '#increment_post_comments_counter' do
    it 'should increment the post.comments_counter by one' do
      post = comment.post
      prev_comments_counter = post.comments_counter

      Comment.create(author: post.author, post:, text: 'test')

      expect(post.comments_counter).to eq(prev_comments_counter + 1)
    end
  end

  describe '#decrement_post_comments_counter' do
    it 'decrement the posts.comments_counter by one' do
      post = comment.post
      comment.destroy
      expect(post.comments_counter).to eq(0)
    end
  end
end
