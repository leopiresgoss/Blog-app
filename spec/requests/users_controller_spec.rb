require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'Get #index' do
    before(:each) { get '/users/' }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'index contains' do
      expect(response.body).to include('list of users')
    end
  end

  describe 'Get #show' do
    before(:each) { get '/users/:id' }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end

    it 'index contains' do
      expect(response.body).to include('details of a given user')
    end
  end
end
