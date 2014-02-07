# encoding: utf-8

class F4F
  attr_reader :boxes

  def initialize(reader)
    @reader = reader
    @boxes = []

    # Scan for boxes in the stream see spec 1.3 F4V box format
    until @reader.pos >= @reader.size
      box = next_box
      @boxes << box
      @reader.pos = box.pos + box.size
    end
  end

  def ok?
    # WARNING: There are rumours that "Some moronic servers add wrong
    # boxSize in header causing fragment verification to fail so we
    # have to fix the boxSize before processing the fragment."

    (@boxes[0].type == Bootstrap::AFRA && @boxes[1].type == Bootstrap::MOOF && @boxes[2].type == Bootstrap::MDAT)
  end

  def next_box
    pos = @reader.pos
    size = @reader.int32
    type = @reader.four_cc
    size = @reader.int64 if size == 1 # For boxes over 4GB the size is moved here.

    header_size = @reader.pos - pos
    content_size = size - header_size

    F4FHeader.new(pos, size, type, @reader.pos, content_size)
  end
end

class F4FHeader < Struct.new(:pos, :size, :type, :content_start, :content_size)
  # pos, starting position within the byte stream
  # size, number of bytes within the box
  # type, descriptive type for the bytes stored in the box
end
