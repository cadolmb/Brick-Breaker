class TransitionState
    def initialize(level)
        @level = level
        @time = Gosu.milliseconds
        @font = Gosu::Font.new(50)
    end

    def update
      if Gosu.milliseconds - @time >= 5000
          $window.set_state("play")
      end
    end

    def draw
        alpha = Math.sin(Math::PI * (Gosu.milliseconds - @time - 1000) / 3000) * 255
        color = Gosu::Color.new(alpha, 255, 255, 255)
        @font.draw_rel("Level: #{@level}", WIDTH / 2, HEIGHT / 3, 0, 0.5, 0.5, 1, 1, color)
    end
end
