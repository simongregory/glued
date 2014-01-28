# encoding: utf-8

class Grabber
  attr_reader :urls

  def initialize(manifest, bootstrap)
    raise "Only one segment can be handled" if bootstrap.segments != 1 #As we've hardcoded 1 below
    raise "Not enough fragments" if bootstrap.fragments < 1
    raise "Too many fragments" if bootstrap.fragments > 2000 #not sure what this limit should be

    @url = "#{manifest.base_ref}/#{manifest.media_filename}Seg1-Frag"
    @total_fragments = bootstrap.fragments
    @urls = []

    build
  end

  private
  def build
    fragment = 1
    while fragment <= @total_fragments
      @urls << "#{@url}#{fragment}"
      fragment += 1
    end
  end

end
