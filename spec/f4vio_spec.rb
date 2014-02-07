# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe F4VIO, 'Flash video binary decoding (big endian)' do

  it 'reads sequences of Unicode 8-bit characters (UTF-8), terminated with 0x00 (unless otherwise specified)' do
    scanner = F4VIO.new "abc\x00xyz\x00"

    expect(scanner.string).to eq('abc')
    expect(scanner.string).to eq('xyz')
  end

  it 'reads bytes' do
    scanner = F4VIO.new 'hello'

    expect(scanner.byte).to eq(104)
    expect(scanner.byte).to eq(101)
    expect(scanner.byte).to eq(108)
    expect(scanner.byte).to eq(108)
    expect(scanner.byte).to eq(111)
  end

  it 'reads 16 bit integers' do
    # eg = {}
  end

  it 'reads 24 bit integers' do
    # eg = {}
  end

  it 'reads 32 bit integers' do
    # eg = {}
  end

  it 'reads 64 bit integers' do
    # eg = {}
  end

  it "reads 4CC, Four-character ASCII code, such as 'moov', encoded as UI32" do
    scanner = F4VIO.new 'moov'
    expect(scanner.four_cc).to eq('moov')
  end
end
