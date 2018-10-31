class Brick
  def initialize(x, y)
    @x, @y = x, y
    @img = Gosu::Image.new('bin/brick.png')
  end
  def x; @x end
  def y; @y end
  def w; @img.width end
  def h; @img.height end

  def draw
    @img.draw(@x, @y, 0)
  end
end
