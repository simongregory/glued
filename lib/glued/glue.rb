# encoding: utf-8

# Create glue with a manifest it recognises and it'll download the media
# file to the local directory.
#
class Glue
  def initialize(url)
    fail "Invalid manifest url '#{url}' (it should end with .f4m)" unless url.to_s =~ /\.f4m$/ # Only by convention

    xml = Curl::Easy.perform(url).body
    manifest = F4M.new(url, xml)
    bootstrap = Bootstrap.new(manifest.bootstrap_info)
    Grabber.new(manifest, bootstrap)

    puts "\rComplete                                                                "
  end
end
