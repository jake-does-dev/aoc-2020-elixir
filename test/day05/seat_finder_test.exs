defmodule SeatFinderTest do
  use ExUnit.Case

  test "highest seat id" do
    seats = FileReader.read_lines("test/day05/puzzleInput.txt")
    assert 944 = SeatFinder.find_max_seat_id(seats)
  end

  test "my seat id" do
    seats = FileReader.read_lines("test/day05/puzzleInput.txt")
    assert [554] = SeatFinder.find_my_seat_id(seats)
  end
end
