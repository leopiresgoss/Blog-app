require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    user = User.create(name: 'Maria', photo: '', bio: 'Teacher from Brazil.')
    post = Post.new(author: user, title: 'Hello 1 (Tom)', text: 'This is my first post')
    Like.new(author: user, post:)
  end

  before { subject.save }

  it 'does not validate without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'does not validate without an author' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
