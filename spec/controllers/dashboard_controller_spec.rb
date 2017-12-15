require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it 'returns correct status code' do
      expect(response.status).to eq 200
    end

    it 'responds to html by default' do
      expect(response.content_type).to eq 'text/html'
    end
  end
end
