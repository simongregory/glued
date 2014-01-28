# encoding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

describe Bootstrap, "parsing a bootstrap" do

  def info
    Base64.strict_decode64 'AAAAjWFic3QAAAAAAAACFAAAAAPoAAAAAAA+QYAAAAAAAAAAAEFXAAAAAAABAAAAGWFzcnQAAAAAAAAAAAEAAAABAAACFAEAAABGYWZydAAAAAAAAAPoAAAAAAMAAAABAAAAAAAAAAAAAB4AAAACFAAAAAAAPjoAAAAHgAAAAAAAAAAAAAAAAAAAAAAA'
  end

  it "decodes bootstrap info (abst) boxes" do
    boot = Bootstrap.new(info)
    box = boot.boxes.first

    box.version.should eq(0)
    box.flags.should eq(0)
    box.bootstrap_info_version.should eq(532)
    box.current_media_time.should eq(4080000)
    box.smpte_timecode_offset.should eq(0)
    box.movie_identifier.should eq('AW')
    box.servers.should eq([])
    box.quality.should eq([])
    box.drm_data.should eq('')
    box.metadata.should eq('')
  end

  it "errors when data is corrupt" do
    expect { Bootstrap.new('Papa+LAZAR0U') }.to raise_error "Computer says no"
  end

  it "decodes segment run table (asrt) boxes" do
    boot = Bootstrap.new(info)
    box = boot.boxes.first

    srt = box.segment_run_tables.first
    sre = srt.run_entry_table.first

    sre.first_segment.should eq(1)
    sre.fragments_per_segment.should eq(532)
  end

  it "determines the number of segments" do
    boot = Bootstrap.new(info)

    boot.segments.should eq(1)
  end

  it "determines the number of fragments" do
    boot = Bootstrap.new(info)

    boot.fragments.should eq(532)
  end


  it "decodes fragment run table (afra) boxes" do
    boot = Bootstrap.new(info)
    box = boot.boxes.first

    box.fragments.should eq(1)

    box.fragment_run_tables.length.should eq(1)

    frt = box.fragment_run_tables.first
    fre = frt.run_entry_table.first

    frt.run_entry_table.length.should eq(3)

    fre.first_fragment.should eq(1)
  end

  it "errors when unexpected fragment boxes are found" do
    bad_info = Base64.strict_decode64 "AAAAjWFic3QAAAAAAAACFAAAAAPoAAAAAAA+QYAAAAAAAAAAAEFXAAAAAAABAAAAGWFzcnQAAAAAAAAAAAEAAAABAAACFAEAAABGYWZ6dAAAAAAAAAPoAAAAAAMAAAABAAAAAAAAAAAAAB4AAAACFAAAAAAAPjoAAAAHgAAAAAAAAAAAAAAAAAAAAAAA"

    expect {
      boot = Bootstrap.new(bad_info)
    }.to raise_error "Unexpected fragment run table box header 'afzt' instead of 'afrt'"
  end

  it "errors unless there are one or more segment table entries" do
  end

  it "errors when unexpected segment boxes are found" do
    bad_info = Base64.strict_decode64 'AAAAjWFic3QAAAAAAAACFAAAAAPoAAAAAAA+QYAAAAAAAAAAAEFXAAAAAAABAAAAGWFzcHQAAAAAAAAAAAEAAAABAAACFAEAAABGYWZydAAAAAAAAAPoAAAAAAMAAAABAAAAAAAAAAAAAB4AAAACFAAAAAAAPjoAAAAHgAAAAAAAAAAAAAAAAAAAAAAA'

    expect {
      boot = Bootstrap.new(bad_info)
    }.to raise_error "Unexpected segment run table box header 'aspt' instead of 'asrt'"
  end
end
