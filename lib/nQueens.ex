defmodule NQueens do
  
  def solver do
    input = IO.gets "Please enter an integer for the size of the board: "
    
    {intVal, _} = Integer.parse(input)

    IO.puts "Awesome! You entered #{intVal}"
    
    solutions = 1..intVal
    |> Enum.to_list
    |> permute
    |> Enum.filter(&diag_test(&1, intVal))
    |> length

    IO.inspect solutions

  end

  def permute([]), do: [[]]
  def permute(list) do
    for x <- list, y <- permute(list -- [x]), do: [x|y]
  end

  def diag_test(list, board_size) do
    nw = no_overlapping_diags_in_one_direction(list, board_size)
    ne = no_overlapping_diags_in_one_direction(reverse_board(list), board_size)

    (nw && ne)
  end

  def reverse_board(list) do
    list 
      |> Enum.reverse
  end

  def no_overlapping_diags_in_one_direction(board, board_size) do

    board
    |> Enum.with_index(1)
    |> Enum.map(fn({a,b}) -> a+b end)
    |> Enum.uniq
    |> (fn(x) -> length(x) == board_size end).()

  end

end
