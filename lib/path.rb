# frozen_string_literal: true

# Find possible path to destination ...
module Path
  # Takes initial position and final position, as separate arrays, on the board position on board
  # Shows the simplest possible way to get from one square to another
  # by outputting all squares the knight will stop on along the way
  def shortest_path(final_pos, grid)
    current_piece = self
    initial_pos = current_piece.position
    queue = [current_piece]
    until current_piece.position == final_pos
      current_piece = create_children(current_piece, grid)
      current_piece.children.each { |child| queue.push(child) }
      current_piece = queue.shift
    end
    path = path_to_destination(current_piece.parent, [final_pos], initial_pos == final_pos)
    print_path(path)
  end

  def path_to_destination(parent, path, zero_path)
    return path if zero_path
    return if parent.nil?

    path << parent.position
    path_to_destination(parent.parent, path, false)
    path.reverse
  end

  def print_path(path)
    moves_num = path.size - 1
    puts "You made it in #{moves_num} #{moves_num == 1 ? 'move' : 'moves'}!  Here's your path:"
    path.each { |pos| p pos }
  end

  private

  def create_children(parent, grid)
    parent.moves(grid).each do |move|
      move = move[0..1]
      child = create_child(move, parent)
      parent.children << child
    end

    parent
  end

  def create_child(move, parent)
    type = parent.type
    child = self.class.new(type, move)
    child.set_parent(parent)
    child
  end
end
