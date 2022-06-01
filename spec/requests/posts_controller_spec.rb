require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'Get #index' do
    before(:each) { get '/users/:id/posts' }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'index contains' do
      expect(response.body).to include('list of posts')
    end
  end

  describe 'Get #show' do
    before(:each) { get '/users/:id/posts/:id' }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end

    it 'index contains' do
      expect(response.body).to include('post for a given user')
    end
  end
end
