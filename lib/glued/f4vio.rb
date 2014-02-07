# encoding: utf-8

class F4VIO < StringIO
  def byte
    read(1).unpack('C').first
  end

  def int16
    read(2).unpack('n').first
  end

  def int24
    "\x00#{read(3)}".unpack('N').first
  end

  def int32
    read(4).unpack('N').first
  end

  def int64
    hi = int32
    lo = int32
    (hi * 4_294_967_296) + lo
  end

  def fourCC
    read(4).unpack('A4').first
  end

  def string
    o, p = pos, 0
    p += 1 while read(1) != "\x00"

    self.pos = o
    str = read(p)
    self.pos += 1

    str
  end

  def byte_ar
    ar = []
    byte.times { ar << byte }
    ar
  end
end
