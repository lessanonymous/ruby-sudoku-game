require_relative "board"

class Game
    
    def initialize

        @board = Board.from_file

    end

    def get_position

        valid_positions = @board.valid_positions
        position = nil
        until valid_positions.include?(position)

            @board.render
            puts "Provide a position in the following format '2 4'"
            position = gets.chomp.split(" ").map(&:to_i)

        end
        position

    end

    def get_value

        valid_chars = "123456789 "
        value = nil 
        until !value.nil? && valid_chars.include?(value)

            @board.render 
            puts "Provide a number between 1 and 9"
            value = gets.chomp
            value = " " if value == "" 

        end
        value

    end

    def play

        until self.solved?

            position = self.get_position
            self.select_position(position)
            value = self.get_value
            self.change_value(position, value)

        end

    end

    def solved?

        @board.solved?

    end

    def select_position(position)

        @board.select(position)

    end

    def change_value(position, value)

        @board[position] = value

    end

end

if __FILE__ == $PROGRAM_NAME

    game = Game.new
    game.play 

end