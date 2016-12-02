require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super 640, 480
		self.caption = "Gosu Tutorial Game"

		@x = Gosu::Image.new "grafiki/x.png"
		@o = Gosu::Image.new "grafiki/o.png"

		@plansza = [
			[:puste, :puste, :puste],
			[:puste, :puste, :puste],
			[:puste, :puste, :puste]
		]
	end

	def update
	end

	def draw
		@plansza.each_with_index do |wiersz, y|
			wiersz.each_with_index do |komorka, x|
				@x.draw 64*x, 64*y, 0
			end
		end
	end
end

window = GameWindow.new
window.show
