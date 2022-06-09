require 'rails_helper'

RSpec.describe '/posts', type: :request do
  subject do
    user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico.')
    Post.create(author: user, title: 'Hello 2', text: 'This is my second post')
  end

  describe 'Get #index' do
    before(:each) { get user_posts_path(subject.author) }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
  end

  describe 'Get #show' do
    before(:each) { get user_post_path(subject.author, subject) }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end
  end
end
