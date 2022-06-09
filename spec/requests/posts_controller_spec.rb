require 'rails_helper'

RSpec.describe '/posts', type: :request do
  before(:all) do
    @user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico.')
    @post1 = Post.create(author: @user, title: 'Hello 1 (Tom)', text: 'This is my first post')
    @post2 = Post.create(author: @user, title: 'Hello 2', text: 'This is my second post')
  end

  describe 'Get #index' do
    before(:each) { get user_posts_path(@user) }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'index contains posts' do
      expect(response.body).to include('Hello 1 (Tom)')
      expect(response.body).to include('Hello 2')
    end
  end

  describe 'Get #show' do
    before(:each) { get user_post_path(@user, @post1) }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end

    it 'contains text from post1' do
      expect(response.body).to include('This is my first post')
    end
  end
end
