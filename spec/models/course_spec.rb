require 'rails_helper'

RSpec.describe Course, type: :model do
  # TODO: Setup fabricator/fixture/FactoryGirl, etc
  let(:course) { Course.create(student_id: 1, name: 'Some class', average: 100.00, last_update: Time.now) }

  describe '#grade' do
    subject {
      course.grade
    }

    describe 'when expecting an A' do
      it { expect(subject).to eq('A') }
    end

    describe 'when expecting a B' do
      before do
        course.update(average: 85.00)
      end

      it { expect(subject).to eq('B') }
    end

    describe 'when expecting a C' do
      before do
        course.update(average: 75.00)
      end

      it { expect(subject).to eq('C') }
    end

    describe 'when expecting a D' do
      before do
        course.update(average: 65.00)
      end

      it { expect(subject).to eq('D') }
    end

    describe 'when expecting a F' do
      before do
        course.update(average: 55.00)
      end

      it { expect(subject).to eq('F') }
    end
  end

  describe '#last_update_formatted' do
    subject {
      course.last_update_formatted
    }

    it { expect(subject).to be_an_instance_of(String) }
  end
end
