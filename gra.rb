require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super 640, 480
		self.caption = "Kółko i krzyżyk"

		@x = Gosu::Image.new "grafiki/x.png"
		@o = Gosu::Image.new "grafiki/o.png"

		@plansza = [
			[:puste, :x, :puste],
			[:puste, :x, :puste],
			[:puste, :o, :x]
		]
	end

	def update
		close if Gosu::button_down? Gosu::KbEscape
	end

	def draw
		@plansza.each_with_index do |wiersz, y|
			wiersz.each_with_index do |komorka, x|
				if komorka == :puste
				elsif komorka == :x
					@x.draw 64*x, 64*y, 0
				else
					@o.draw 64*x, 64*y, 0
				end
			end
		end
	end
end

window = GameWindow.new
window.show
