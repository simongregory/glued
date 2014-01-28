# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe "grabbing fragments" do

  it "builds a nice long list of url fragments" do
    f4m = double(F4M)
    grabber = Grabber.new(f4m)

    grabber.urls.should_not be_empty
  end

  it "downloads the nice long list of fragments" do
  end
end
