# encoding: utf-8

require 'curb'
require 'base64'
require 'nokogiri'

require 'glue/f4m'
require 'glue/f4vio'
require 'glue/bootstrap'
require 'glue/grabber'

class Glue
  VERSION = '0.1.0'

  def initialize(url)
    raise "Invalid manifest url '#{url}' (it should end with .f4m)" unless url.to_s =~ /\.f4m$/ #Only by convention

    xml = Curl::Easy.perform(url).body
    manifest = F4M.new(url, xml)
    bootstrap = Bootstrap.new(manifest.bootstrap_info)
    grabber = Grabber.new(manifest, bootstrap)

    puts "\rComplete                                                                "
  end
end
