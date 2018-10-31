class Paddle
  def initialize
    @img = Gosu::Image.new('bin/paddle.png')
    @x = WIDTH / 2 - @img.width / 2
    @y = HEIGHT * 0.9
    @step = 7.5
  end
  def x; @x end
  def y; @y end
  def w; @img.width end
  def h; @img.height end

  def move(s)
    case s
    when "left"
      @x -= @step
    when "right"
      @x += @step
    end
    checkInBounds
  end

  def checkInBounds
    if @x < 0; @x = 0 end
    if @x > WIDTH - w; @x = WIDTH - w end
  end

  def draw
    @img.draw(@x, @y, 0)
  end
end
