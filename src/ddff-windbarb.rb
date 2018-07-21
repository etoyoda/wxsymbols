#!/usr/bin/env ruby

require 'draw.rb'

class WindBarb

  def initialize args
    @d = args[0].to_i
    @f = args[1].to_i
    @fn = args[2]
    @img = Draw.new(64)
  end

  def short_barb ofs
    upwind = @d * 10 - 90
    upwind += 360 if upwind < 0
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 60, 4
  end
  
  def long_barb ofs
    upwind = @d * 10 - 90
    upwind += 360 if upwind < 0
    @img.center
    @img.move upwind, ofs
    @img.line upwind + 60, 7
  end
  
  def run
    upwind = @d * 10 - 90
    upwind += 360 if upwind < 0
    @img.center
    @img.line upwind, 25
    case @f
    when 1...8
      short_barb 20
    when 8...48
      round5 = ((@f * 5 + 2.5) / 5).floor
      round10 = (round5 / 2).floor
      ofs = 25
      round10.times { |i|
        long_barb ofs
        ofs -= 3
      }
      if round5 & 5 then
        short_barb ofs
      end
    when 48...98
    when 98...148
    else raise "i dunno f=#{@f}"
    end
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

WindBarb.new(ARGV).run
