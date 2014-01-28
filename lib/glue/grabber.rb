# encoding: utf-8

class Grabber
  attr_reader :urls

  def initialize(man)
    @manifest = man
    @urls = []

    @urls << 'foo'
  end

end
