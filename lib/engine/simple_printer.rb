module Engine
  class SimplePrinter < Printer
    attr_reader :board_format

    def initialize
      @board_format = {
          unknown_cell: '.',
          clear_cell: ' ',
          bomb: '#',
          flag: 'F'
      }
    end
  end
end
