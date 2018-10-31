class WinState
  def initialize
    @font = Gosu::Font.new(50)
    @message = "You Win"
    @option1 = "Menu"
    @option2 = "Quit"
    @select = 0

    @move_sound = Gosu::Sample.new('bin/sounds/menu_move_sound.wav')
    @select_sound = Gosu::Sample.new('bin/sounds/menu_select_sound.wav')
  end

  def button_down(id)
    case id
    when Gosu::KB_UP, Gosu::KB_DOWN
      @move_sound.play
    when Gosu::KB_RETURN
      @select_sound.play
    end
  end

  def update
    if Gosu.button_down? Gosu::KB_UP
      @select = 0 if @select == 1
    elsif Gosu.button_down? Gosu::KB_DOWN
      @select = 1 if @select == 0
    end

    if Gosu.button_down? Gosu::KB_RETURN
      case @select
      when 0
        $window.set_state("menu")
      when 1
        $window.close
      end
    end
  end

  def draw
    green = Gosu::Color::GREEN
    yellow = Gosu::Color::YELLOW
    white = Gosu::Color::WHITE
    pad = 50
    @font.draw_rel(@message, WIDTH / 2, HEIGHT / 3, 0, 0.5, 0.5, 1, 1, green)

    case @select
    when 0
      @font.draw_rel(@option1, WIDTH / 2, HEIGHT / 3 + pad, 0, 0.5, 0, 0.5, 0.5, yellow)
      @font.draw_rel(@option2, WIDTH / 2, HEIGHT / 3 + pad * 2, 0, 0.5, 0, 0.4, 0.4, white)
    when 1
      @font.draw_rel(@option1, WIDTH / 2, HEIGHT / 3 + pad, 0, 0.5, 0, 0.4, 0.4, white)
      @font.draw_rel(@option2, WIDTH / 2, HEIGHT / 3 + pad * 2, 0, 0.5, 0, 0.5, 0.5, yellow)
    end
  end
end
