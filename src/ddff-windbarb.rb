#!/usr/bin/env ruby

require 'draw.rb'

def atoi a
  Integer(a)
rescue
  -1
end

class WindBarb

  def initialize args
    @d = atoi(args[0])
    @f = atoi(args[1])
    @fn = args[2]
    @img = Draw.new(64)
    @img.fg = 0x000040
  end

  def upwind
    d = if @d < 0 then 27 else @d end
    d * 10 - 90
  end

  def short_barb ofs
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 70, 6
    @img.center
    @img.move upwind, ofs - 0.5
    @img.line upwind + 70, 6
    ofs - 3
  end
  
  def long_barb ofs
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 70, 10
    @img.center
    @img.move upwind, ofs - 0.5
    @img.line upwind + 70, 10
    ofs - 3
  end

  def cross ofs
    @img.center
    @img.move upwind, ofs
    @img.move upwind + 45, 5
    @img.line upwind + 45 + 180, 11
    @img.center
    @img.move upwind, ofs
    @img.move upwind - 45, 5
    @img.line upwind - 45 + 180, 11
  end

  def pennant ofs
    @img.center
    @img.move upwind, ofs + 1
    @img.line upwind + 90, 10
    cursor = @img.cursor
    4.times { |ishift|
      @img.center
      @img.move upwind, ofs - ishift
      @img.line_to(*cursor)
    }
    ofs - 6
  end

  def shaft
    @img.line upwind, 25
    @img.center
    @img.move upwind - 90, 0.7
    @img.line upwind, 25
  end
  
  def run
    @img.center
    case @f
    when 0
      @img.circle 5
    when -1
      shaft
      cross 25
    when 1...8
      shaft
      short_barb 20
    when 8...300
      shaft
      ticks = ((@f + 2.5) / 5).floor
      t50 = (ticks / 10).floor
      ticks -= t50 * 10
      t10 = (ticks / 2).floor
      ticks -= t10 * 2
      t5 = ticks
      $stderr.puts "@f=#{@f} t5=#{t5} t10=#{t10} t50=#{t50}" if $DEBUG
      ofs = 25
      t50.times {|i|
        ofs = pennant(ofs)
      }
      t10.times { |i|
        ofs = long_barb(ofs)
      }
      t5.times {
        short_barb ofs
      }
    else
      raise "i dunno f=#{@f}"
    end
    cross 10 if @d < 0
    @img.halo
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

WindBarb.new(ARGV).run
