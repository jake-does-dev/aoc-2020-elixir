defmodule SeatFinder do
  def find_seat(seat_string) do
    {row, column} = Enum.split(String.codepoints(seat_string), 7)

    %{row: transform(row), column: transform(column)}
  end

  @spec find_max_seat_id(List.t(String.t())) :: number
  def find_max_seat_id(seat_strings) do
    seat_strings
    |> Enum.map(&find_seat(&1))
    |> Enum.map(&compute_seat_id(&1))
    |> Enum.max()
  end

  @spec find_my_seat_id(List.t(String.t())) :: [number]
  def find_my_seat_id(seat_strings) do
    seat_ids =
      seat_strings
      |> Enum.map(&find_seat(&1))
      |> Enum.map(&compute_seat_id(&1))

    {min, max} = Enum.min_max(seat_ids)
    Enum.to_list(min..max) -- seat_ids
  end

  @spec compute_seat_id(%{column: number, row: number}) :: number
  def compute_seat_id(seat_map) do
    seat_map.row * 8 + seat_map.column
  end

  defp transform(input) do
    case to_binary(input) do
      <<x::7>> -> x
      <<x::3>> -> x
    end
  end

  defp to_binary(input) do
    input
    |> Enum.map(fn x ->
      case x do
        "F" -> 0
        "B" -> 1
        "L" -> 0
        "R" -> 1
      end
    end)
    |> Enum.into(<<>>, fn bit -> <<bit::1>> end)
  end
end
