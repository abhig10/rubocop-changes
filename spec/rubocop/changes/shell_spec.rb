# frozen_string_literal: true

require 'rubocop/changes/shell'

RSpec.describe Rubocop::Changes::Shell do
  describe '.run' do
    it 'returns stripped utf-8 output for normal command output' do
      allow(described_class).to receive(:`).with('echo test').and_return("test \n")

      expect(described_class.run('echo test')).to eq('test')
    end

    it 'sanitizes invalid bytes before stripping output' do
      invalid_output = "\xC3 \n".dup.force_encoding(Encoding::US_ASCII)
      allow(described_class).to receive(:`).with('echo bad').and_return(invalid_output)

      expect { described_class.run('echo bad') }.not_to raise_error
      expect(described_class.run('echo bad')).to eq('')
    end
  end
end
