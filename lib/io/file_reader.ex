defmodule FileReader do
  def read_ints(path) do
    path
    |> read_lines()
    |> Enum.map(&String.to_integer/1)
  end

  def read_lines(path, splitter \\ "\n") do
    File.read!(path)
    |> String.split(splitter)
  end
end
