require_relative "tile"
require "colorize"
require "byebug"

class Board

    def self.from_file

        file_names = ["puzzles/sudoku1.txt", "puzzles/sudoku2.txt", "puzzles/sudoku3.txt"]
        grid = Array.new(9) { Array.new(9) }
        file = open(file_names.sample) do | file |

            valid_chars = "1234567890"
            chars = []
            file.each_char do | char |

                chars << char if valid_chars.include?(char)

            end
            grid.map! do | row |

                row.map! do | tile |

                    tile = Tile.new(chars.shift)

                end

            end

        end
        Board.new(grid)

    end
    
    def initialize(grid)

        @grid = grid

    end

    def [](position)

        row, col = position
        @grid[row][col].value

    end

    def select(position)

        row, col = position
        @grid[row][col].select  

    end

    def []=(position, value)

        row, col = position
        @grid[row][col].value = value

    end

    def render

        system("clear")
        puts 
        puts "  0 1 2 3 4 5 6 7 8".colorize(:blue)
        puts "  " + "-".colorize(:blue) * 17
        @grid.each_with_index do | row, row_idx |

            print_row = "#{row_idx.to_s}|".colorize(:blue)
            row.each_with_index do | tile, col_idx | 
                
                if col_idx == 2 || col_idx == 5 || col_idx == 8

                print_row += "#{tile.value}#{"|".colorize(:blue)}"
                
                else
                    
                    print_row += "#{tile.value}|"

                end

            end
            puts print_row
            if row_idx == 2 || row_idx == 5 || row_idx == 8

                puts "  " + "-".colorize(:blue) * 17
                
            else

                puts "  " + "-" * 17

            end

        end

    end

    def solved?

        self.solved_rows? && self.solved_columns? && self.solved_boxes?

    end

    def solved_rows?

        @grid.all? do | row |

            values = []
            row.each do | tile | 
                
                return false if tile.value == " "
                values << tile.value

            end
            values.uniq.length == 9

        end

    end

    def solved_columns?

        @grid.transpose.all? do | row |

            values = []
            row.each do | tile | 
                
                return false if tile.value == " "
                values << tile.value

            end
            values.uniq.length == 9

        end

    end

    def solved_boxes?

        left_values, middle_values, right_values = [], [], []
        boxes = [left_values, middle_values, right_values]
        @grid.each_with_index do | row, row_idx |

            row.each_with_index do | tile, col_idx |

                return false if tile.value == " "
                self.add_tile_value_to_box(boxes, tile, col_idx)

            end
            if row_idx == 2 || row_idx == 5 || row_idx == 8

                return false unless self.valid_boxes?(boxes)
                left_values, middle_values, right_values = [], [], []

            end

        end
        true

    end

    def add_tile_value_to_box(boxes, tile, col_idx)

        if (0..2).include?(col_idx)

            boxes[0] << tile.value 

        elsif (3..5).include?(col_idx)

            boxes[1] << tile.value

        elsif (6..8).include?(col_idx)

            boxes[2] << tile.value

        end

    end

    def valid_boxes?(boxes)

        boxes.all? { | box | box.uniq.length == 9 }

    end

    def valid_positions

        positions = []
        @grid. each_with_index do | row, row_idx |

            row.each_with_index do | tile, col_idx | 

                positions << [row_idx, col_idx] if tile.mutable

            end

        end
        positions

    end

end