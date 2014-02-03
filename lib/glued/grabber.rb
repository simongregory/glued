# encoding: utf-8

class Grabber
  attr_reader :urls

  def initialize(manifest, bootstrap, io=nil)
    raise "Only one segment can be handled" if bootstrap.segments != 1 #As we've hardcoded 1 below
    raise "Not enough fragments" if bootstrap.fragments < 1
    raise "Too many fragments" if bootstrap.fragments > 10000 #not sure what this limit should be

    @uri = "#{manifest.media_filename}.flv"
    @url = "#{manifest.base_ref}/#{manifest.media_filename}Seg1-Frag"
    @total_fragments = bootstrap.fragments
    @urls = []
    @downloaded_fragments = []
    @fragments_downloaded = 0

    #TODO: Track how much has already been downloaded and append from that point
    raise "Aborting as the download target file '#{@uri}' already exists" if File.exist? @uri

    @out = io ||= File.new(@uri, 'ab')
    @out.write(flv_header(1,1))

    build
  end

  private

  #TODO: Inspect first fragment, test for audio and video, write header accordingly
  def flv_header(audio, video)
    #Audio and video need to be a 1 or 0
    flv_header = ["464c5601050000000900000000"].pack("H*")

    result = audio << 2 | video
    flv_header[4] = [result].pack('C')

    flv_header
  end

  def build
    #TODO, correctly set the fragment start
    fragment = 1
    while fragment <= @total_fragments
      @urls << "#{@url}#{fragment}"
      fragment += 1
    end

    @urls.each { |url| download url }
  end

  def download url
    file_name = url.split('/').pop

    dl = fetch_and_report(url)

    raise "Invalid content type '#{dl.content_type}' for fragment #{file_name}." unless dl.content_type == 'video/f4f'

    reader = F4VIO.new(dl.body)
    f4f = F4F.new(reader)

    raise "Fragment did not verify" unless f4f.ok?

    f4f.boxes.each do |box|
      if box.type == 'mdat'
        reader.pos = box.content_start
        @out.write(reader.read(box.content_size))
      end
    end

    @fragments_downloaded += 1
  end

  def fetch_and_report(url)
    start_time = Time.now

    dl = Curl::Easy.perform(url)

    report(dl.body.length, Time.now-start_time)

    dl
  end

  def report(number_of_bytes, in_seconds)
    bps = (number_of_bytes*8) / in_seconds
    kbps = bps/1000
    mbps = bps/1000000

    print "\rDownloading #{@fragments_downloaded+1}/#{@total_fragments} at #{mbps.round(2)} Mbps"
  end
end

