defmodule PasswordPolicy do
  def num_valid_occurrence_based(data) do
    num_valid =
      for d <- data do
        mapping = extract(d)

        num_occurrences =
          mapping.password
          |> String.codepoints()
          |> Enum.count(fn x -> x == mapping.char end)

        cond do
          mapping.first_value <= num_occurrences && num_occurrences <= mapping.last_value -> 1
          true -> 0
        end
      end

    Enum.sum(num_valid)
  end

  def num_valid_position_based(data) do
    num_valid =
      for d <- data do
        mapping = extract(d)

        first = extract_value_at(mapping.password, mapping.first_value)
        last = extract_value_at(mapping.password, mapping.last_value)

        cond do
          first == last -> 0
          first == mapping.char or last == mapping.char -> 1
          true -> 0
        end
      end

    Enum.sum(num_valid)
  end

  defp extract(raw_string) do
    [first_last | [char | password]] = Regex.split(~r/ /, raw_string)

    [first_value, last_value] =
      Regex.split(~r/-/, first_last)
      |> Enum.map(fn x -> String.to_integer(x) end)

    char = Regex.split(~r/:/, char)

    %{first_value: first_value, last_value: last_value, char: hd(char), password: hd(password)}
  end

  defp extract_value_at(password, location) do
    Enum.at(String.codepoints(password), location - 1)
  end
end
