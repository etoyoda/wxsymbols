#!/usr/bin/env ruby

require 'draw.rb'

class NCloudCircle

  def initialize args
    @n = args[0].to_i
    @fn = args[1]
    @img = Draw.new(16)
  end

  def paint n
    case n
    when 0
      :do_nothing
    when 1
      @img.move 90, 3
      @img.line 271, 6
    when 2
      @img.line 0, 3
      @img.center
      @img.move 270, 0.5
      @img.line 0, 3
      @img.center
      @img.move 270, 1
      @img.line 0, 2
      @img.center
      @img.move 270, 1.5
      @img.line 0, 2
      @img.center
      @img.move 270, 2
      @img.line 0, 1
      @img.center
      @img.move 270, 2.5
      @img.line 0, 1
    when 3
      paint 1
      paint 2
    when 4
      paint 1
      @img.center
      @img.move 75, 3
      @img.line 271, 5
      @img.center
      @img.move 60, 3
      @img.line 271, 6
      @img.center
      @img.move 50, 3
      @img.line 271, 5
      @img.center
      @img.move 40, 3
      @img.line 271, 5
      @img.center
      @img.move 30, 3
      @img.line 271, 5
      @img.center
      @img.move 20, 3
      @img.line 271, 3
      @img.center
      @img.move 10, 3
      @img.line 271, 3
      @img.center
      @img.move 10, 3
      @img.line 271, 3
    when 5
      paint 4
      @img.center
      @img.line 180, 3
    when 6
      paint 5
      @img.center
      @img.line 160, 3
      @img.center
      @img.line 140, 3
      @img.center
      @img.line 120, 3
      @img.center
      @img.line 100, 3
      @img.center
      @img.line 80, 3
    when 7
      @img.center
      @img.move 60, 3
      @img.line 271, 6
      @img.center
      @img.move 80, 3
      @img.line 271, 6
      @img.center
      @img.move 100, 3
      @img.line 271, 6
    when 8
      @img.circle 3
      @img.circle 2.5
      @img.circle 2
      @img.circle 1.5
      @img.circle 1
    when 9
      @img.circle 3
      @img.move 45, 3
      @img.line 225, 6
      @img.center
      @img.move -45, 3
      @img.line -225, 6
    when 'nil'
      @img.circle 3
      @img.move 45, 3
      @img.line 225, 6
    else
      raise "i dunno f=#{@f}"
    end
  end

  def run
    @img.center
    @img.circle 3
    paint @n
    @img.halo
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

NCloudCircle.new(ARGV).run
