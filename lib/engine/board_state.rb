module Engine
  class BoardState
    def initialize(board, **options)
      Engine::Validate.type 'board', Board, board

      @board = board
      @options = options
    end

    def get
      state = Array.new(@board.height) { Array.new(@board.width) }
      @board.each do |cell|
        state[cell.y - 1][cell.x - 1] = state cell
      end

      state
    end

    private

    def state(cell)
      if cell.is_discovered
        if cell.has_mine
          :discovered_mine
        elsif cell.neighbor_mine > 0
          cell.neighbor_mine
        else
          :discovered
        end
      else
        if @options[:xray] and cell.has_mine
          :undiscovered_mine
        elsif cell.has_flag
          :undiscovered_flag
        else
          :undiscovered
        end
      end
    end
  end
end

