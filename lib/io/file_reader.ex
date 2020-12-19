defmodule FileReader do
  def read_ints(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
