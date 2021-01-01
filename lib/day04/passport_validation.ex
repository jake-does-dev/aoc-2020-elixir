defmodule PassportValidation do
  @required_fields_list ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def num_valid_passports(passports, is_check_validity) do
    passports
    |> Enum.map(&String.replace(&1, "\n", " "))
    |> Enum.filter(&valid_passport?(&1, is_check_validity, MapSet.new(@required_fields_list)))
    |> Enum.count()
  end

  def valid_passport?(passport, is_check_validity, required_fields) do
    without_cid =
      passport
      |> String.split(" ")
      |> extract_keys(is_check_validity)
      |> MapSet.delete("cid")

    MapSet.subset?(required_fields, without_cid)
  end

  @spec extract_keys(any) :: any
  def extract_keys(passport_data, is_check_validity \\ false)
  def extract_keys(passport_data, false), do: extract_keys_no_validity_check(passport_data)
  def extract_keys(passport_data, true), do: extract_keys_with_validity_check(passport_data)

  defp extract_keys_no_validity_check(passport_data) do
    Enum.reduce(passport_data, MapSet.new(), fn entry, keys ->
      [key, _] = String.split(entry, ":")
      MapSet.put(keys, key)
    end)
  end

  defp extract_keys_with_validity_check(passport_data) do
    Enum.reduce(passport_data, MapSet.new(), fn entry, keys ->
      [key, val] = String.split(entry, ":")

      if valid?(key, val) do
        MapSet.put(keys, key)
      else
        keys
      end
    end)
  end

  defp valid?("byr", val), do: between?(val, 1920, 2002)
  defp valid?("iyr", val), do: between?(val, 2010, 2020)
  defp valid?("eyr", val), do: between?(val, 2020, 2030)
  defp valid?("hcl", val), do: String.match?(val, ~r/#[A-Fa-f0-9]{6}$/)
  defp valid?("pid", val), do: String.match?(val, ~r/^\d{9}$/)

  defp valid?("ecl", val),
    do: MapSet.member?(MapSet.new(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]), val)

  defp valid?("hgt", val) do
    case Regex.run(~r/(\d+)(in|cm)/, val) do
      [_, amount, "cm"] -> between?(amount, 150, 193)
      [_, amount, "in"] -> between?(amount, 59, 76)
      nil -> false
    end
  end

  defp valid?("cid", _), do: true
  defp valid?(_, _), do: false

  defp between?(val, lower, upper) do
    as_int = String.to_integer(val)
    lower <= as_int && as_int <= upper
  end
end
