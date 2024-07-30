# spec/bulk_creation_spec.rb

require 'spec_helper'

RSpec.describe ResponsableAPI::BulkCreation do
  let(:klass) { double('ModelClass') }
  let(:params) { [{ some_attribute: 'value1' }, { some_attribute: 'value2' }] }

  subject { described_class.new(params, klass) }

  describe '#initialize' do
    it 'initializes with bulk_create_params and klass' do
      expect(subject.instance_variable_get(:@params)).to eq(params)
      expect(subject.instance_variable_get(:@klass)).to eq(klass)
    end
  end

  describe '#call' do
    context 'when all records are valid' do
      it 'creates all records' do
        params.each do |param|
          record_double = double('Record', save: true)
          allow(klass).to receive(:new).with(param).and_return(record_double)
        end

        subject.call
        expect(subject.errors).to be_empty
      end
    end

    context 'when some records are invalid' do
      it 'does not create invalid records and populates errors' do
        params.each_with_index do |param, index|
          valid = index.even?
          record_double = double('Record', save: valid, errors: double(full_messages: ['error message']))
          allow(klass).to receive(:new).with(param).and_return(record_double)
        end

        subject.call
        expect(subject.errors).not_to be_empty
      end
    end
  end

  describe '#errors?' do
    context 'when there are errors' do
      it 'returns true' do
        subject.errors << { message: 'error' }
        expect(subject.errors?).to be true
      end
    end

    context 'when there are no errors' do
      it 'returns false' do
        expect(subject.errors?).to be false
      end
    end
  end
end
