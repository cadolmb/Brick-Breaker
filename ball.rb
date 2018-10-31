class Ball
  def initialize
    @img = Gosu::Image.new('bin/ball.png')
    @x = WIDTH / 2 - w / 2
    @y = HEIGHT / 2
    @xv = -0.25 + rand(0.5)
    @yv = 5.0

    @die_sound = Gosu::Sample.new('bin/sounds/die_sound.wav')
  end
  def x; @x end
  def y; @y end
  def w; @img.width end
  def h; @img.height end
  def xv; @xv end
  def yv; @yv end

  def setVect(xv, yv)
    @xv, @yv = xv, yv
  end

  def bounce(xv, yv)
    @xv *= xv
    @yv *= yv
    @yv *= 1.2
    maxspeed
  end

  def maxspeed
    if @xv > 8.0; @xv = 10.0 end
    if @xv < -8.0; @xv = -10.0 end
    if @yv > 15.0; @yv = 10.0 end
    if @yv < -15.0; @yv = -10.0 end
  end

  def walls
    if @x <= 0 || @x > WIDTH - w
      @xv *= -1
      @x += @xv
    elsif @y < 0
      @yv *= -1
      @y += @yv
    elsif @y > HEIGHT
      die
    end
  end

  def die
    @die_sound.play
    $window.set_state("dead")
  end

  def update
    @x += @xv
    @y += @yv
    walls
  end

  def draw
    @img.draw(@x, @y, 0)
  end
end
