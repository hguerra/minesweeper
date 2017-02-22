module Engine
  class Cell
    attr_accessor :has_mine, :is_discovered, :has_flag, :neighbor_mine
    attr_reader :x, :y, :neighborhood

    def initialize(x, y)
      Engine::Validate.type 'x', Integer, x
      Engine::Validate.type 'y', Integer, y

      Engine::Validate.positive_argument 'x', x
      Engine::Validate.positive_argument 'y', y

      @x = x
      @y = y
      @is_discovered = false
      @has_flag = false
      @has_mine = false
      @neighborhood = []
      @neighbor_mine = 0
    end

    def eql?(other)
      @x == other.x and @y == other.y
    end
  end
end