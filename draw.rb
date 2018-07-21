#!/usr/bin/env ruby

class Draw

  def initialize size, xpc = 0x543210
    @size = size
    @buf = [(xpc >> 16) & 0xFF, (xpc >> 8) & 0xff, xpc & 0xFF].pack('c3') * (size * size)
    @cx = @cy = 0
  end

  attr_reader :size

  def moveto x, y
    @cx, @cy = x, y
  end

  def center
    moveto @size / 2, @size / 2
  end

  def pixel_at x, y, c
    ofs = (x.floor + @size * y.floor) * 3
    $stderr.puts "pixel_at(#{x}, #{y}, #{c})" if $DEBUG
    @buf.setbyte ofs, (c >> 16) & 0xFF
    @buf.setbyte ofs+1, (c >> 8) & 0xff
    @buf.setbyte ofs+2, c & 0xFF
  end

  def line_toward dx, dy, c = 0
    len = ([dx.abs, dy.abs].max * 3 / 2).ceil
    len.times { |i|
      ux = @cx + dx * i / len
      uy = @cy + dy * i / len
      pixel_at ux, uy, c
    }
    @cx += dx
    @cy += dy
  end

  def move deg, len
    x2 = @cx + Math.cos(deg * Math::PI / 180)
    y2 = @cy + Math.sin(deg * Math::PI / 180)
    move_to(x2, y2)
  end

  def line deg, len, c = 0
    x2 = Math.cos(deg * Math::PI / 180) * len
    y2 = Math.sin(deg * Math::PI / 180) * len
    line_toward(x2, y2, c)
  end

  def saveppm fnam
    File.open(fnam, 'wb:BINARY') {|ofp|
      ofp.printf("P6\n%u %u\n%u\n", @size, @size, 255)
      ofp.write @buf
    }
  end

  def savepng fnam
    tmp = "#{fnam}.ppm"
    saveppm(tmp)
    system("convert -transparent '#543210' #{tmp} PNG:#{fnam}")
    File.unlink(tmp)
  end

end

if $0 == __FILE__
  d = Draw.new(64)
  d.moveto 10, 10
  d.line 0, 45, 0xFF0000
  d.line 120, 45, 0x00FF00
  d.line 240, 45, 0x0000FF
  d.savepng('zzztest.png')
end
