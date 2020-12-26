defmodule PassportValidation do
  @required_fields_list ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  @spec num_valid_passports(any) :: non_neg_integer
  def num_valid_passports(passports) do
    passports
    |> Enum.map(&String.replace(&1, "\n", " "))
    |> Enum.filter(&valid_passport?(&1, MapSet.new(@required_fields_list)))
    |> Enum.count()
  end

  @spec extract_keys(any) :: any
  def extract_keys(passport) do
    Enum.reduce(passport, MapSet.new(), fn e, acc ->
      [key, _] = String.split(e, ":")
      MapSet.put(acc, key)
    end)
  end

  @spec valid_passport?(String.t(), MapSet.t(String.t())) :: boolean
  def valid_passport?(passport, required_fields) do
    without_cid =
      extract_keys(String.split(passport, " "))
      |> MapSet.delete("cid")

    MapSet.subset?(required_fields, without_cid)
  end
end
