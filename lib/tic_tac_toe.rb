WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def play(board)
  while !over?(board)
   turn(board)
 end
def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end
def draw?(board)
  !won?(board) && full?(board)
 end
  def over?(board)
    turn(board)
  end
  move(board, input, current_player(board))
  display_board(board)
end

def valid_move?(board, input)
  input.to_i.between?(1,9) && !position_taken?(board, input.to_i-1)
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position(board, combo[0]) == position(board, combo[1]) &&
    position(board, combo[1]) == position(board, combo[2]) &&
    position_taken?(board, combo[0])
  end
end

def position(board, location)
  board[location.to_i]
end

def position_taken?(board, location)
  !(position(board, location).nil? || position(board, location) == "")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def move(board, location)
  if valid_move?(board, location)
    board[location.to_i-1] = current_player(board)
  end
end

def winner(board)
  if winning_combo = won?(board)
    position(board, winning_combo.first)
  end
end


if won?(board)
  puts "Congratulations! #{winner(board)}"
elsif draw?(board)
  puts "Cats Game!"
end
