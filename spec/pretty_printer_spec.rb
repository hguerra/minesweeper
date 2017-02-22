require 'spec_helper'

RSpec.describe Engine::PrettyPrinter do
  before(:each) do
    @printer = Engine::PrettyPrinter.new
  end

  after(:each) do
    @printer = nil
  end

  describe '#print' do
    it 'should print' do
      board_state = Engine::BoardState.new(create_board)
      expect { @printer.print(board_state) }.to output("╔═════════════╗\n║ Minesweeper ║\n╚═════════════╝\n B  1  _ \n 2  *  * \n *  *  F \n").to_stdout
    end

    def create_board
      board = Engine::Board.new(3, 3)

      discovered_mine = Engine::Cell.new(1, 1)
      discovered_mine.is_discovered = true
      discovered_mine.has_mine = true
      board.add discovered_mine

      discovered_neighbor_mine = Engine::Cell.new(2, 1)
      discovered_neighbor_mine.is_discovered = true
      discovered_neighbor_mine.neighbor_mine = 1
      board.add discovered_neighbor_mine

      discovered = Engine::Cell.new(3, 1)
      discovered.is_discovered = true
      board.add discovered

      discovered_neighbor_mine = Engine::Cell.new(1, 2)
      discovered_neighbor_mine.is_discovered = true
      discovered_neighbor_mine.neighbor_mine = 2
      board.add discovered_neighbor_mine

      board.add Engine::Cell.new(2, 2)
      board.add Engine::Cell.new(3, 2)

      undiscovered_mine = Engine::Cell.new(1, 3)
      undiscovered_mine.has_mine = true
      board.add undiscovered_mine

      board.add Engine::Cell.new(2, 3)

      undiscovered_flag = Engine::Cell.new(3, 3)
      undiscovered_flag.has_mine = true
      undiscovered_flag.has_flag = true
      board.add undiscovered_flag

      board
    end
  end
end
