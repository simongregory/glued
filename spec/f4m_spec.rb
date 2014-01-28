# encoding: utf-8

describe F4M, "Loading manifests" do

  describe "a recorded manifest" do

    before(:each) do
      @manifest = F4M.new('http://cloud.org/only/fools/vod.f4m',
                          IO.read('spec/fixtures/vod.f4m'))
    end

    after(:each) do
      @manifest = nil
    end

    it "creates a base url for fragments downloads" do
      @manifest.base_ref.should eq('http://cloud.org/only/fools')
    end

    it "defines the total duration of the media in seconds" do
      @manifest.duration.should eq(4080)
    end

    it "has bootstrap information" do
      @manifest.bootstrap_info.should_not be_empty
    end

    it "defines the media filename" do
      @manifest.media_filename.should eq('some-audio-video-')
    end

  end

  describe "loading a live manifest" do
    it "raises errors if a live manifest is used" do
      expect {
          F4M.new('http://cloud.org/and/horses/live.f4m',
          IO.read('spec/fixtures/live.f4m'))
      }.to raise_error "Only recorded streams are supported."
    end
  end

  describe "loading manifests with unrecognised namespaces" do
    it "raises errors with no namespaces" do
      expect {
          F4M.new('http://only.fools/and/horses/live.f4m',
          IO.read('spec/fixtures/no_namespace.f4m'))
      }.to raise_error "Invalid manifest namespace. It was not found but should have been http://ns.adobe.com/f4m/1.0"
    end

    it "raises errors for incompatible namespaces" do
      expect {
          F4M.new('http://only.fools/and/horses/live.f4m',
          IO.read('spec/fixtures/bad_namespace.f4m'))
      }.to raise_error "Invalid manifest namespace. It was http://ns.adobe.com/f4m/2.0 but should have been http://ns.adobe.com/f4m/1.0"
    end
  end
end