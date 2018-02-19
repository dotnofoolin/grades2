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
end
