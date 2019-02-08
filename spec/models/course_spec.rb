require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { Fabricate(:course) }

  describe '#grade' do
    subject {
      course.grade
    }

    describe 'when expecting an A' do
      before do
        course.update(average: 95.00)
      end

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

  describe '#health_bar_color_class' do
    subject {
      course.health_bar_color_class
    }

    describe 'when grade is an A' do
      before do
        course.update(average: 95.00)
      end

      it { expect(subject).to eq('is-success') }
    end

    describe 'when grade is a B' do
      before do
        course.update(average: 85.00)
      end

      it { expect(subject).to eq('is-primary') }
    end

    describe 'when grade is a C' do
      before do
        course.update(average: 75.00)
      end

      it { expect(subject).to eq('is-info') }
    end

    describe 'when grade is a D' do
      before do
        course.update(average: 65.00)
      end

      it { expect(subject).to eq('is-warning') }
    end

    describe 'when grade is a F' do
      before do
        course.update(average: 55.00)
      end

      it { expect(subject).to eq('is-danger') }
    end
  end
end
