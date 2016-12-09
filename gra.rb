require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super 800, 600
		self.caption = "Kółko i krzyżyk"

		@x = Gosu::Image.new "grafiki/x.png"
		@o = Gosu::Image.new "grafiki/o.png"

		@font = Gosu::Font.new(100)

		@wygrane_a = 0
		@wygrane_b = 0

		ustaw_tekst

		@plansza = [
			[:puste, :puste, :puste],
			[:puste, :puste, :puste],
			[:puste, :puste, :puste]
		]

		@nastepny = :x
		@blokada = 0
	end

	def ustaw_tekst
		@tekst = @wygrane_a.to_s + ' : ' + @wygrane_b.to_s
	end

	def update
		close if Gosu::button_down? Gosu::KbEscape
		if @blokada > 0
			@blokada -= 1
		else
			klikanie
		end
	end

	def klikanie
		if Gosu::button_down? Gosu::MsLeft
			x_px = mouse_x - 194
			y_px = mouse_y - 114
			reszta_x = x_px % 94
			reszta_y = y_px % 94
			if reszta_x < 64 and reszta_y < 64
				x = (x_px / 94).floor
				y = (y_px / 94).floor
				if x >= 0 and x <= 2 and y >= 0 and y <= 2
					kliknieto x, y
				end
			end
		end
	end

	def kliknieto x, y
		if @plansza[y][x] == :puste
			@plansza[y][x] = @nastepny
			if (@plansza[y][0] == @plansza[y][1] and @plansza[y][1] == @plansza[y][2])
				if @nastepny == :x
					@wygrane_a += 1
					ustaw_tekst
				end
			end
			@nastepny = if(@nastepny == :x)
				:o
			else
				:x
			end
			@blokada = 30
		end
	end

	def draw
		Gosu::draw_rect 0, 0, 640, 480, Gosu::Color::WHITE
		@plansza.each_with_index do |wiersz, y|
			wiersz.each_with_index do |komorka, x|
				if komorka == :puste
					Gosu::draw_rect 94*x+194, 94*y+114, 64, 64, Gosu::Color::YELLOW
				elsif komorka == :x
					@x.draw 94*x+194, 94*y+114, 1
				else
					@o.draw 94*x+194, 94*y+114, 1
				end
			end
		end
		@font.draw(@tekst, 10, 10, 2, 1, 1, Gosu::Color::GREEN)
	end

	def needs_cursor?
		true
	end
end

window = GameWindow.new
window.show
