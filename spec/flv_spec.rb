# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe FLV do
  describe 'Creating FLV file header' do
    it 'generates a header for a file containing audio and video' do
      expect(FLV.header).to eq "FLV\x01\x05\x00\x00\x00\t\x00\x00\x00\x00"
    end

    it 'generates a header for a file containing audio only' do
      expect(FLV.header(1, 0)).to eq "FLV\x01\x04\x00\x00\x00\t\x00\x00\x00\x00"
    end

    it 'generates a header for a file containing video only' do
      expect(FLV.header(0, 1)).to eq "FLV\x01\x01\x00\x00\x00\t\x00\x00\x00\x00"
    end
  end
end
