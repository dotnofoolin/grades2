require 'rails_helper'
require 'importer/hac'

RSpec.describe Importer::Hac do
  let(:base_action) { Importer::Hac.new }

  subject {
    VCR.use_cassette(cassette, record: :once) do
      action
    end
  }

  before do
    reset_env_vars
  end

  describe '#new' do
    it { expect(base_action).to be_an_instance_of(Importer::Hac) }

    describe 'when missing env variables' do
      describe 'when missing HAC_URL' do
        before do
          ENV.delete 'HAC_URL'
        end

        it { expect { base_action }.to raise_error(Importer::Hac::CredentialsMissingError) }
      end

      describe 'when missing HAC_SCHOOL' do
        before do
          ENV.delete 'HAC_SCHOOL'
        end

        it { expect { base_action }.to raise_error(Importer::Hac::CredentialsMissingError) }
      end

      describe 'when missing HAC_USERNAME' do
        before do
          ENV.delete 'HAC_USERNAME'
        end

        it { expect { base_action }.to raise_error(Importer::Hac::CredentialsMissingError) }
      end

      describe 'when missing HAC_PASSWORD' do
        before do
          ENV.delete 'HAC_PASSWORD'
        end

        it { expect { base_action }.to raise_error(Importer::Hac::CredentialsMissingError) }
      end
    end
  end

  describe '#import' do
    let(:action) { base_action.import }

    describe 'when successful' do
      let(:cassette) { 'hac_all_reports' }

      before do
        Student.delete_all
        Course.delete_all
        Assignment.delete_all
        subject
      end

      it 'creates Student records' do
        expect(Student.all.count).to be > 0
      end

      it 'creates Course records' do
        expect(Course.all.count).to be > 0
      end

      it 'creates Assignment records' do
        expect(Assignment.all.count).to be > 0
      end
    end

    describe 'when errors occur' do
      let(:cassette) { 'hac_all_reports_error' }

      it 'raises error' do
        expect { subject }.to raise_error(Importer::Hac::OtherError)
      end
    end
  end
end
