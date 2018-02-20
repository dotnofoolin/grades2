require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:assignment) { Fabricate(:assignment) }

  describe '#due_date_formatted' do
    subject {
      assignment.due_date_formatted
    }

    it { expect(subject).to be_an_instance_of(String) }
  end

  describe '#date_assigned_formatted' do
    subject {
      assignment.date_assigned_formatted
    }

    it { expect(subject).to be_an_instance_of(String) }
  end

  describe '#average' do
    subject {
      assignment.average
    }

    describe 'when total_points is greater than 0' do
      before do
        assignment.update(score: 50.0, total_points: 100.0)
      end

      it { expect(subject).to be_an_instance_of(Float) }

      it 'should return valid average' do
        expect(subject).to eq(50.0)
      end
    end

    describe 'when total_points is 0' do
      before do
        assignment.update(score: 50.0, total_points: 0)
      end

      it { expect(subject).to be_an_instance_of(Float) }

      it 'should return valid average' do
        expect(subject).to eq(100.0)
      end
    end
  end

  describe '#grade' do
    subject {
      assignment.grade
    }

    describe 'when expecting an A' do
      before do
        assignment.update(score: 90.0, total_points: 100.0)
      end

      it { expect(subject).to eq('A') }
    end

    describe 'when expecting a B' do
      before do
        assignment.update(score: 80.0, total_points: 100.0)
      end

      it { expect(subject).to eq('B') }
    end

    describe 'when expecting a C' do
      before do
        assignment.update(score: 70.0, total_points: 100.0)
      end

      it { expect(subject).to eq('C') }
    end

    describe 'when expecting a D' do
      before do
        assignment.update(score: 60.0, total_points: 100.0)
      end

      it { expect(subject).to eq('D') }
    end

    describe 'when expecting a F' do
      before do
        assignment.update(score: 50.0, total_points: 100.0)
      end

      it { expect(subject).to eq('F') }
    end
  end
end
