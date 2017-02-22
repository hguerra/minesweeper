module Engine
  class PrettyPrinter < Printer
    attr_reader :board_format

    def initialize
      @board_format = {
          unknown_cell: '*',
          clear_cell: '_',
          bomb: 'B',
          flag: 'F'
      }
    end

    def print(board_state)
      super
    end
  end
end