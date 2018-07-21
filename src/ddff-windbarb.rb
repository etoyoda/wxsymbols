require 'draw.rb'

class WindBarb

  def initialize args
    @d = args[0].to_i
    @f = args[1].to_i
    @fn = args[2]
    @img = Draw.new(64)
  end

  

  def run
    @img.center
    upwind = @d * 10 - 90
    upwind += 360 if upwind < 0
    @img.line upwind, 25
    case @f
    when 1...8
      @img.center
      @img.move upwind, 25
      @img.line upwind + 120, 3
    when 8...48
    when 48...98
    when 98...148
    else raise 'i dunno'
    end
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

WindBarb.new(ARGV).run
