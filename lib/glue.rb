# encoding: utf-8

require 'curb'
require 'base64'
require 'nokogiri'

require 'glue/f4m'
require 'glue/f4vio'
require 'glue/bootstrap'

class Glue
  VERSION = '0.1.0'

  def initialize(url)
    raise "Invalid manifest url #{url}" unless url.to_s =~ /\.f4m$/ #Only by convention
  end
end
