#!/usr/bin/env ruby

require 'draw.rb'

class WindBarb

  def initialize args
    @d = args[0].to_i
    @f = args[1].to_i
    @fn = args[2]
    @img = Draw.new(64)
  end

  def upwind
    @d * 10 - 90
  end

  def short_barb ofs
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 70, 4
    ofs - 3
  end
  
  def long_barb ofs
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 70, 7
    ofs - 3
  end

  def pennant ofs
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 70, 7
    cursor = @img.cursor
    3.times { |ishift|
      @img.center
      @img.move upwind, ofs - ishift
      @img.line_to(*cursor)
    }
    ofs - 4
  end
  
  def run
    @img.center
    @img.line upwind, 25
    case @f
    when 1...8
      short_barb 20
    when 8...300
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
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

WindBarb.new(ARGV).run
