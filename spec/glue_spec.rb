# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'Glue' do
  it 'downloads hds fragments and glues them together' do
    # one day it just might
  end

  it 'raises errors when the manifest url looks doubtful' do
    expect { Glue.new('/steptoe/and/son.f5m') }.to raise_error "Invalid manifest url '/steptoe/and/son.f5m' (it should end with .f4m)"
  end
end
