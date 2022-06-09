require 'rails_helper'

RSpec.describe '/users', type: :request do
  before(:all) do
    @user1 = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Lisa', photo: '', bio: 'Teacher from Poland.')
  end

  describe 'Get #index' do
    before(:each) { get users_path }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it "index contains user's name" do
      expect(response.body).to include('Tom')
      expect(response.body).to include('Lisa')
    end
  end

  describe 'Get #show' do
    before(:each) do
      get user_path(@user1.id)
    end

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end

    it "show contains user's name" do
      expect(response.body).to include('Tom')
    end
  end
end
