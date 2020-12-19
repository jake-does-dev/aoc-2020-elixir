defmodule ExpenseReport do

  def find_multiple_of_pair(data, target_sum) do
    data
    |> get_pair(target_sum)
    |> multiply
  end

  def find_multiple_of_triple(data, target_sum) do
    data
    |> get_triple(target_sum)
    |> multiply
  end

  defp get_pair(data, target_sum) do
    p = for i <- data, j <- data, i + j == target_sum, do: [i, j]
    Enum.reduce(p, fn(x, _) -> x end)
  end

  defp get_triple(data, target_sum) do
    p = for i <- data, j <- data, k <- data, i + j + k == target_sum, do: [i, j, k]
    Enum.reduce(p, fn(x, _) -> x end)
  end

  defp multiply([]), do: 1
  defp multiply([head | tail]), do: head * multiply(tail)
end
