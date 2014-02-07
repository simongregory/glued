# encoding: utf-8

class Glue
  def initialize(url)
    fail "Invalid manifest url '#{url}' (it should end with .f4m)" unless url.to_s =~ /\.f4m$/ # Only by convention

    xml = Curl::Easy.perform(url).body
    manifest = F4M.new(url, xml)
    bootstrap = Bootstrap.new(manifest.bootstrap_info)
    grabber = Grabber.new(manifest, bootstrap)

    puts "\rComplete                                                                "
  end
end
