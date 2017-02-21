module Engine
  class Board
    def initialize(width, height)
      Engine::Validate.type 'width', Integer, width
      Engine::Validate.type 'height', Integer, height

      raise ArgumentError, "Argument 'width' and 'height' must be greater than 0, got #{width} and #{height}." if width < 1 and height < 1

      @width = width
      @height = height
      @cells = {}

      (1..@height).each { |y| @cells[y] = [] }
    end

    def add(cell)
      Engine::Validate.type 'cell', Cell, cell
      raise ArgumentError, "Argument 'cell.x' and 'cell.y' should be a values between width (#{@width}) and height #{@height},
                            got #{cell.x} and #{cell.y}." unless valid_cell?(cell.x, cell.y)

      add_neighborhood(cell)
      @cells[cell.y][cell.x] = cell
      cell
    end

    def get(x, y)
      Engine::Validate.type 'x', Integer, x
      Engine::Validate.type 'y', Integer, y

      Engine::Validate.positive_argument 'x', x
      Engine::Validate.positive_argument 'y', y

      raise ArgumentError, "Argument 'x' and 'y' should be a values between width (#{@width}) and height #{@height},
                            got #{x} and #{y}." unless valid_cell?(x, y)

      @cells[y][x]
    end

    def each_neighbor(cell)
      Engine::Validate.type 'cell', Cell, cell

      cell.neighborhood.each do |coord|
        yield get(coord[0], coord[1]) if block_given?
      end
    end

    private

    def add_neighborhood(cell)
      neighbors = [
          [cell.x - 1, cell.y - 1],
          [cell.x, cell.y - 1],
          [cell.x + 1, cell.y - 1],
          [cell.x - 1, cell.y],
          [cell.x + 1, cell.y],
          [cell.x - 1, cell.y + 1],
          [cell.x, cell.y + 1],
          [cell.x + 1, cell.y + 1],
      ]

      neighbors.each do |coord|
        cell.neighborhood << coord if valid_cell?(coord[0], coord[1])
      end
    end

    def valid_cell?(x, y)
      x >= 1 and x <= @width and y >= 1 and y <= @height
    end
  end
end
