module Engine
  class Minesweeper
    def initialize(width, height, num_mines, prng = Random.new)
      Engine::Validate.type 'num_mines', Integer, num_mines
      Engine::Validate.positive_argument 'num_mines', num_mines

      load_board width, height, num_mines, prng

      @still_playing = true
    end

    def still_playing?
      @still_playing
    end

    def play(x, y)
      false unless still_playing?

      @board.get(x, y).tap do |cell|
        return false if cell.is_discovered or cell.has_flag

        cell.is_discovered = true
        if cell.has_mine
          @still_playing = false
        else
          @board.each_neighbor(cell) do |neighbor|
            neighbor.is_discovered = true unless neighbor.is_discovered and neighbor.has_flag and neighbor.has_mine
          end if cell.neighbor_mine == 0
        end

        return true
      end
    end

    private

    def load_board(width, height, num_mines, prng)
      @board = Board.new width, height
      @num_mines = num_mines

      (1..height).each do |y|
        (1..width).each do |x|
          @board.add Engine::Cell.new(x, y)
        end
      end

      (1..num_mines).each do
        @board.get(prng.rand(1..width), prng.rand(1..height)).tap do |cell|
          cell.has_mine = true
          @board.each_neighbor(cell) { |neighbor| neighbor.neighbor_mine += 1 }
        end
      end
    end
  end
end