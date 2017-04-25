defmodule NQueens do
  
  def solver do
    input = IO.gets "Please enter an integer for the size of the board: "
    {intVal, _} = Integer.parse(input)
    IO.puts "Awesome! You entered #{intVal}"
    IO.inspect(solve_n_queens(intVal))
  end

  def solve_n_queens(i) do
    1..i
    |> Enum.to_list
    |> generate_safe_horizontal_and_vertical_placements
    |> remove_unsafe_diagonal_moves(i)
    |> count_passing_configurations
  end

  def count_passing_configurations(ls) do
    length(ls)  
  end

  def generate_safe_horizontal_and_vertical_placements(ls) do
    permute(ls)
  end


  def permute([]), do: [[]]
  def permute(list) do
    for x <- list, y <- permute(list -- [x]), do: [x|y]
  end


  def remove_unsafe_diagonal_moves(ls, board_size) do
    ls
    |> Enum.filter(&diag_test(&1, board_size))
  end

  def diag_test(list, board_size) do
    nw = no_overlapping_diags_in_one_direction?(list, board_size)
    ne = no_overlapping_diags_in_one_direction?(reverse_board(list), board_size)
    (nw && ne)
  end

  def reverse_board(list) do
    list 
      |> Enum.reverse
  end

  def no_overlapping_diags_in_one_direction?(board, board_size) do
    board
    |> add_horizontal_index
    |> sum_x_y_coordinates_of_queens
    |> do_all_diagonals_have_only_one_queen?(board_size)
  end

  def add_horizontal_index(board) do
    board
    |> Enum.with_index(1)
  end

  def sum_x_y_coordinates_of_queens(board) do
    board
    |> Enum.map(fn({a,b}) -> a+b end)
  end

  def do_all_diagonals_have_only_one_queen?(board, board_size) do
    board
    |> Enum.uniq
    |> (fn(x) -> length(x) == board_size end).()
  end

end
