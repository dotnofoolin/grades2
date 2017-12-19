require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { Fabricate(:student_with_courses) }

  describe '#courses_for_dashboard' do
    subject {
      student.courses_for_dashboard
    }

    describe 'should return array of courses' do
      it { expect(subject).not_to be_empty }
    end
  end
end
