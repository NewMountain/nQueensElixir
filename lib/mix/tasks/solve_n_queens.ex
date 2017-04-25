
defmodule Mix.Tasks.SolveNQueens do
    use Mix.Task

    @shortdoc "Sugar to run the program more easily."
    def run(_) do
        NQueens.solver
    end

end