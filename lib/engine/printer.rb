module Engine
  class Printer
    def board_format
      raise NotImplementedError, "Method 'board_format' must be defined in subclass."
    end

    def print(board_state)
      Engine::Validate.type 'board_state', BoardState, board_state

      board_state.get.each do |col|
        row = ''
        col.each do |state|
          case state
            when :undiscovered
              row << " #{board_format[:unknown_cell]} "
            when :discovered
              row << " #{board_format[:clear_cell]} "
            when :discovered_mine
              row << " #{board_format[:bomb]} "
            when :undiscovered_mine
              row << " #{board_format[:bomb]} "
            when :undiscovered_flag
              row << " #{board_format[:flag]} "
            else
              row << " #{state} "
          end
        end

        puts row
      end
    end
  end
end

