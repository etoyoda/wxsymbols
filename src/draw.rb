#!/usr/bin/env ruby

class Draw

  def initialize size, xpc = 0x543210
    @size = size
    @buf = [(xpc >> 16) & 0xFF, (xpc >> 8) & 0xff, xpc & 0xFF].pack('c3') * (size * size)
    @cx = @cy = 0
    @xpc = xpc
    @bg = 0xFFFFFF
    @fg = 0
  end

  attr_reader :size
  attr_accessor :bg, :fg

  def cursor
    [@cx, @cy]
  end

  def move_to x, y
    @cx, @cy = x, y
  end

  def center
    move_to @size / 2, @size / 2
  end

  def setpixel x, y, c
    ofs = (x.floor + @size * y.floor) * 3
    $stderr.puts "setpixel(#{x}, #{y}, #{c})" if $DEBUG
    @buf.setbyte ofs, (c >> 16) & 0xFF
    @buf.setbyte ofs+1, (c >> 8) & 0xff
    @buf.setbyte ofs+2, c & 0xFF
  end

  def getpixel x, y
    ofs = (x.floor + @size * y.floor) * 3
    r = (@buf.byteslice(ofs).unpack('C').first << 16)
    r |= (@buf.byteslice(ofs+1).unpack('C').first << 8)
    r |= @buf.byteslice(ofs+2).unpack('C').first
    r
  rescue => e
    $stderr.puts [x, y, ofs].inspect
    raise e
  end

  def dimcolor c
    r = @bg
    [0xFF0000, 0xFF00, 0xFF].each {|mask|
      r |= mask & ((c & mask) + (@bg & mask)) / 2
    }
    r
  end

  def circle r
    dim = dimcolor(@fg)
    @size.times {|iy|
      @size.times {|ix|
        dr = (Math::hypot(ix - @cx, iy - @cy) - r).abs
	case dr
	when 0..(0.4) then setpixel(ix, iy, @fg)
	when (0.4)..(0.7) then setpixel(ix, iy, dim)
	end
      }
    }
  end

  def circle_fill r
    dim = dimcolor(@fg)
    @size.times {|iy|
      @size.times {|ix|
        cr = Math::hypot(ix - @cx, iy - @cy)
	if (cr < r) then
	  setpixel(ix, iy, @fg)
	elsif (cr < r + 0.4) then
	  setpixel(ix, iy, dim)
	end
      }
    }
  end

  NEXT = [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]

  def halo
    (1...(@size-1)).each {|iy|
      (1...(@size-1)).each {|ix|
        hit = false
	NEXT.each {|dx, dy|
	  col = getpixel(ix+dx, iy+dy)
	  case col
	  when @xpc, @bg then :do_nothing
	  else hit = true
	  end
	}
	if hit and getpixel(ix, iy) == @xpc
	  setpixel(ix, iy, @bg)
	end
      }
    }
  end

  def line_toward dx, dy, c = @fg
    $stderr.puts "line_toward(dx=#{dx}, dy=#{dy}, #{c})" if $DEBUG
    len = ([dx.abs, dy.abs].max * 3 / 2).ceil
    len.times { |i|
      ux = @cx + dx * i / len
      uy = @cy + dy * i / len
      setpixel ux, uy, c
    }
    @cx += dx
    @cy += dy
  end

  def line_to x, y, c = @fg
    $stderr.puts "line_to(x=#{x}, y=#{y}, #{c})" if $DEBUG
    dx = x - @cx
    dy = y - @cy
    line_toward dx, dy, c
  end

  def move deg, len
    x2 = @cx + Math.cos(deg * Math::PI / 180) * len
    y2 = @cy + Math.sin(deg * Math::PI / 180) * len
    move_to(x2, y2)
  end

  def line deg, len, c = @fg
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
    xpc = sprintf('#%06X', @xpc)
    system("convert -transparent '#{xpc}' #{tmp} PNG:#{fnam}")
    File.unlink(tmp)
  end

  def tell io = $stderr
    io.puts "@cx=#{@cx} @cy=#{@cy}"
  end

end

if $0 == __FILE__
  d = Draw.new(64)
  d.move_to 10, 10
  d.line 0, 45, 0xFF0000
  d.line 120, 45, 0x00FF00
  d.line 240, 45, 0x0000FF
  d.savepng('zzztest.png')
end
