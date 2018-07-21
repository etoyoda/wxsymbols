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
    @img.savepng @fn
    $stderr.puts @fn if $stderr.tty?
  end

end

WindBarb.new(ARGV).run
