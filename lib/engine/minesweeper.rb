module Engine
  class Minesweeper
    def initialize(width, height, num_mines, prng = Random.new)
      Engine::Validate.type 'num_mines', Integer, num_mines
      Engine::Validate.positive_argument 'num_mines', num_mines

      @board = Board.new width, height
      @num_mines = num_mines

      @num_clean_cells = @board.width * @board.height - @num_mines
      @num_discovered_cells = 0
      @alive = true

      load_board prng
    end

    def still_playing?
      @alive and @num_discovered_cells < @num_clean_cells
    end

    def play(x, y)
      false unless still_playing?

      @board.get(x, y).tap do |cell|
        return false if cell.is_discovered or cell.has_flag

        click cell
        if cell.has_mine
          @alive = false
        else
          click_around cell
        end

        return true
      end
    end

    def flag(x, y)
      false unless still_playing?

      @board.get(x, y).tap do |cell|
        if cell.has_flag
          cell.has_flag = false
        elsif not cell.is_discovered
          cell.has_flag = true
        else
          return false
        end

        return true
      end
    end

    def victory?
      @alive and not still_playing?
    end

    def board_state(**options)
      if options[:xray] and still_playing?
        options[:xray] = false
        warn "Warning: Argument 'xray' is valid only if the game is finished."
      end

      BoardState.new(@board, options)
    end

    private

    def load_board(prng)
      (1..@board.height).each do |y|
        (1..@board.width).each do |x|
          @board.add Engine::Cell.new(x, y)
        end
      end

      (1..@num_mines).each do
        @board.get(prng.rand(1..@board.width), prng.rand(1..@board.height)).tap do |cell|
          cell.has_mine = true
          @board.each_neighbor(cell) { |neighbor| neighbor.neighbor_mine += 1 }
        end
      end
    end

    def click(cell)
      cell.is_discovered = true
      @num_discovered_cells += 1
    end

    def click_around(starting_coord)
      return unless starting_coord.neighbor_mine == 0

      queue = [starting_coord]
      done = Set.new [starting_coord]

      until queue.empty?
        coord = queue.shift
        @board.each_neighbor(coord) do |neighbor|
          unless done.include? neighbor
            unless neighbor.is_discovered and neighbor.has_flag and neighbor.has_mine
              click neighbor
              done << neighbor
              queue << neighbor if neighbor.neighbor_mine == 0
            end
          end
        end
      end
    end
  end
end