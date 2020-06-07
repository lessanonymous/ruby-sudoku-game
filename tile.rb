require "colorize"

class Tile

    attr_reader :value, :mutable
    
    def initialize(value)

        if value == "0"

            @value = " "
            @mutable = true

        else

            @value = value
            @mutable = false

        end

    end

    def value=(value)

        @value = value.colorize(:yellow) if @mutable

    end

    def select

        @value = @value.colorize(:color => :blue, :background => :white)

    end

end