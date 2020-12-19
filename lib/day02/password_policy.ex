defmodule PasswordPolicy do
  def num_valid_occurrence_based(data) do
    num_valid = for d <- data do
      mapping = extract(d)

      mapping.password
      |> String.codepoints()
      |> Enum.count(fn(x) -> x == mapping.char end)
      |> do_transform(mapping.min, mapping.max)
    end

    Enum.sum(num_valid)
  end

  def extract(raw_string) do
    [min_max | [char | password]] = Regex.split(~r/ /, raw_string)

    [min, max] =
      Regex.split(~r/-/, min_max)
      |> Enum.map(fn(x) -> String.to_integer(x) end)

    char = Regex.split(~r/:/, char)

    %{min: min, max: max, char: hd(char), password: hd(password)}
  end

  def do_transform(num_occurrences, min, max) do
    if min <= num_occurrences && num_occurrences <= max do
      1
    else
      0
    end
  end
end
