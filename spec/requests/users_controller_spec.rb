require 'rails_helper'

RSpec.describe '/users', type: :request do
  subject do
    User.create(name: 'Maria', email: 'maria@email.com', password: 'password', photo: '', bio: 'Teacher from Brazil.',
                confirmed_at: Time.now)
  end

  describe 'Get #index' do
    before(:each) { get users_path }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
  end

  describe 'Get #show' do
    before(:each) { get user_path(subject.id) }

    it 'the status should be 200(:ok)' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
  end
end
