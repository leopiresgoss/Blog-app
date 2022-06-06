class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_destroy :decrement_user_posts_counter
  after_save :increment_user_posts_counter

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_user_posts_counter
    author.decrement!(:posts_counter)
  end
end
