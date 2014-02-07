# encoding: utf-8

# FLV file utility methods
#
module FLV
  def self.header(audio = 1, video = 1)
    # Audio and video need to be a 1 or 0
    flv_header = ['464c5601050000000900000000'].pack('H*')

    result = audio << 2 | video
    flv_header[4] = [result].pack('C')

    flv_header
  end
end
