require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Maria', photo: '', bio: 'Teacher from Brazil.') }

  before { subject.save }

  it 'does not validate without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'does not validate if posts_counter is not >= 0' do
    subject.posts_counter = -5
    expect(subject).to_not be_valid
  end
end
