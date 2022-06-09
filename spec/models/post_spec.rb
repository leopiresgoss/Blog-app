require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    user = User.create(name: 'Maria', photo: '', bio: 'Teacher from Brazil.')
    Post.new(author: user, title: 'Hello 1 (Tom)', text: 'This is my first post')
  end
  before { subject.save }

  it 'does not validate without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'does not validate without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'does not validate when a title is blank' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'does not validate when a title exceeds 250char' do
    subject.title = 'kkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    kkkkkkkkkkkkkkkkkkk'

    expect(subject).to_not be_valid
  end

  it 'does not validate without a text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'does not validate if likes_counter is not >= 0' do
    subject.likes_counter = -5
    expect(subject).to_not be_valid
  end

  it 'does not validate if comments_counter is not >= 0' do
    subject.comments_counter = -5
    expect(subject).to_not be_valid
  end
end
