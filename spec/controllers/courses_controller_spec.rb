require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:course) { Fabricate(:course) }

  describe 'show' do
    before do
      get :show, params: { id: course.id }
    end

    it 'returns correct status code' do
      expect(response.status).to eq 200
    end

    it 'responds to html by default' do
      expect(response.content_type).to eq 'text/html'
    end
  end
end
