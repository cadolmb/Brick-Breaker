require './paddle.rb'
require './ball.rb'
require './bricks.rb'

class PlayState
  def initialize(level)
    @paddle = Paddle.new
    @ball = Ball.new

    @level = level
    createLevel(@level)

    @break_sound = Gosu::Sample.new('bin/sounds/break_sound.wav')
    @paddle_sound = Gosu::Sample.new('bin/sounds/paddle_sound.wav')
  end

  def createLevel(level)
    @bricks = []
    margin = 3

    rows = open("./levels/level_#{level}.txt").read.split("\n")
    rows.each_index do |row|
      items = rows[row].split(" ")
      items.each_index do |i|
        if items[i] == "1"
          @bricks.push(Brick.new((i) * WIDTH / items.length + margin, row * HEIGHT / 2 / rows.length))
        end
      end
    end
  end

  def paddleCollision(b, p)
    if  b.x + b.w >= p.x &&
        b.x <= p.x + p.w &&
        b.y + b.h >= p.y &&
        b.y <= p.y + p.h
    then
      if b.y + b.h <= p.y + p.w / 4
        return true
      else
        return false
      end
    end
  end

  def brickCollision(bl, br)
    if  bl.x + bl.w >= br.x &&
        bl.x <= br.x + br.w &&
        bl.y + bl.h >= br.y &&
        bl.y <= br.y + br.h
    then
      if bl.y + bl.h - bl.yv <= br.y
        return "top"
      elsif bl.y - bl.yv >= br.y + br.h
        return "bottom"
      elsif bl.x < br.x
        return "left"
      elsif bl.x > br.x
        return "right"
      end
    end
  end

  def update
    @paddle.checkInBounds
    @ball.update
    # Input
    if Gosu.button_down? Gosu::KB_LEFT
      @paddle.move("left")
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      @paddle.move("right")
    end
    # Collision
    if paddleCollision(@ball, @paddle)
      bx = @ball.x + @ball.w / 2
      by = @ball.y + @ball.h / 2
      px = @paddle.x + @paddle.w / 2
      py = @paddle.y + @paddle.h / 2
      angle = Gosu.angle(px, py, bx, by)
      dist = Gosu.distance(bx, by, px, py)

      if angle > 70 && angle < 180; angle = 70
      elsif angle < 290 && angle > 180; angle = 290
      end
      @ball.setVect(Gosu.offset_x(angle, dist / 8), Gosu.offset_y(angle, dist / 4))
      @paddle_sound.play
    end

    @bricks.each do |brick|
      case brickCollision(@ball, brick)
      when "top"
        @ball.bounce(1, -1)
        @bricks.delete(brick)
        @break_sound.play
      when "bottom"
        @ball.bounce(1, -1)
        @bricks.delete(brick)
        @break_sound.play
      when "left"
        @ball.bounce(-1, 1)
        @bricks.delete(brick)
        @break_sound.play
      when "right"
        @ball.bounce(-1, 1)
        @bricks.delete(brick)
        @break_sound.play
      end
    end

    if @bricks.size == 0
      $window.next_level
    end
  end

  def draw
    @paddle.draw
    @ball.draw
    @bricks.each { |brick| brick.draw }
  end
end
