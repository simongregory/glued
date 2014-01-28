# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe "grabbing fragments" do

  before(:each) do
    @bs = double(Bootstrap)
    @f4m = double(F4M)
  end

  after(:each) do
    @bs = nil
    @f4m = nil
  end

  it "builds a nice long list of url fragments" do
    @f4m.stub(:base_ref).and_return('http://the.young.ones')
    @f4m.stub(:media_filename).and_return('some-audio-video-')
    @bs.stub(:segments).and_return(1)
    @bs.stub(:fragments).and_return(20)

    grabber = Grabber.new(@f4m, @bs)

    expect(grabber.urls.first).to eq('http://the.young.ones/some-audio-video-Seg1-Frag1')
    expect(grabber.urls.last).to eq('http://the.young.ones/some-audio-video-Seg1-Frag20')
  end

  it "fails without the correct number of segments" do
    @bs.stub(:segments).and_return(0)
    expect { Grabber.new(@f4m, @bs) }.to raise_error "Only one segment can be handled"

    @bs.stub(:segments).and_return(1)
    @bs.stub(:fragments).and_return(0)

    expect { Grabber.new(@f4m, @bs) }.to raise_error "Not enough fragments"
  end

  it "downloads the nice long list of fragments" do
  end
end
