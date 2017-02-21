module Engine
  class Minesweeper
    def initialize(width, height, num_mines, prng = Random.new)
      Engine::Validate.type 'num_mines', Integer, num_mines
      Engine::Validate.positive_argument 'num_mines', num_mines

      load_board width, height, num_mines, prng
    end

    def board_state
      {undiscovered: [], discovered: []}
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

      (1..num_mines).each { @board.get(prng.rand(1..width), prng.rand(1..height)).has_mine = true }
    end
  end
end