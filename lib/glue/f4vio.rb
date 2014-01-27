# encoding: utf-8

class F4VIO < StringIO

  def byte
    self.read(1).unpack('C').first
  end

  def int16
    self.read(2).unpack('n').first
  end

  def int24
    "\x00#{self.read(3)}".unpack('N').first
  end

  def int32
    self.read(4).unpack('N').first
  end

  def int64
    hi = int_32
    lo = int_32
    (hi * 4294967296) + lo
  end

  def fourCC
    self.read(4).unpack('A4').first
  end

  def string
    o, p = self.pos, 0
    p += 1 while (self.read(1) != "\x00")

    self.pos = o
    str = self.read(p)
    self.pos += 1

    str
  end

end
