class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates_associated :post, :author
  validates :text, presence: true

  before_destroy :decrement_post_comments_counter
  after_save :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter)
  end
end
