require 'gosu'
require './gameStates/menuState.rb'
require './gameStates/playState.rb'
require './gameStates/transitionState.rb'
require './gameStates/deadState.rb'
require './gameStates/winState.rb'

WIDTH = 800
HEIGHT = 600
TITLE = "Brick Breaker"

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = TITLE

    @level = 1
    @current_state = "menu"
    @state = {
      menu: MenuState.new,
      play: PlayState.new(@level),
      transition: TransitionState.new(@level),
      dead: DeadState.new,
      win: WinState.new
    }

    @song = Gosu::Song.new('bin/MiiSong.mp3')
    @song.play(true)
  end

  def next_level
    @level += 1

    if @level > 3
      set_state("win")
    else
      set_state("transition")
    end
  end

  def set_state(s)
    case s
    when "menu"
      @state[:menu] = MenuState.new
      @current_state = "menu"
    when "play"
      @state[:play] = PlayState.new(@level)
      @current_state = "play"
    when "transition"
      @state[:transition] = TransitionState.new(@level)
      @current_state = "transition"
    when "dead"
      @state[:dead] = DeadState.new
      @current_state = "dead"
      @level = 1
    when "win"
      @state[:win] = WinState.new
      @current_state = "win"
    end
  end

  def button_down(id)
    case @current_state
    when "menu"
      @state[:menu].button_down(id)
    when "dead"
      @state[:dead].button_down(id)
    when "win"
      @state[:win].button_down(id)
    end
    case id
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def update
    case @current_state
    when "menu"
      @state[:menu].update
    when "play"
      @state[:play].update
    when "transition"
      @state[:transition].update
    when "dead"
      @state[:dead].update
    when "win"
      @state[:win].update
    end
  end

  def draw
    case @current_state
    when "menu"
      @state[:menu].draw
    when "play"
      @state[:play].draw
    when "transition"
      @state[:transition].draw
    when "dead"
      @state[:dead].draw
    when "win"
      @state[:win].draw
    end
  end
end
