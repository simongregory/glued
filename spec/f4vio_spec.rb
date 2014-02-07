# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe F4VIO, 'Flash video binary decoding (big endian)' do

  it 'reads sequences of Unicode 8-bit characters (UTF-8), terminated with 0x00 (unless otherwise specified)' do
    scanner = F4VIO.new "abc\x00xyz\x00"

    scanner.string.should eq('abc')
    scanner.string.should eq('xyz')
  end

  it 'reads bytes' do
    scanner = F4VIO.new 'hello'

    scanner.byte.should eq(104)
    scanner.byte.should eq(101)
    scanner.byte.should eq(108)
    scanner.byte.should eq(108)
    scanner.byte.should eq(111)
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
    scanner.fourCC.should eq('moov')
  end

end
