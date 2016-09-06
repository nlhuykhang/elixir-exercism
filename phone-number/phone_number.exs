defmodule Phone do

  defp is_valid(n) do
    only_number = n |> String.trim |> String.replace(~r/[^0-9]/, "")

    cond do
      Regex.match?(~r/[^-.0-9()\s]+/, n) == true -> false
      String.length(only_number) < 10 -> false
      String.length(only_number) > 11 -> false
      String.length(only_number) == 11 && check_11_length_number(only_number) -> false
      true -> true
    end
  end

  defp check_11_length_number(n) do
    String.first(n) != "1"
  end

  @spec number(String.t) :: String.t
  def number(raw) do
    cond do
      is_valid(raw) -> process_valid_number(raw)
      true -> "0000000000"
    end
  end

  defp process_valid_number(n) do

    only_number = n |> String.trim |> String.replace(~r/[^0-9]/, "")

    length = String.length only_number

    cond do
      length == 11 && !check_11_length_number(only_number) -> String.slice(only_number, 1..-1)
      true -> only_number
    end
  end

  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> String.slice(0..2)
  end

  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    normalize = number(raw)

    area = area_code(normalize)

    mid = String.slice(normalize, 3..5)

    last = String.slice(normalize, 6..-1)

    "(" <> area <> ") " <> mid <> "-" <> last

  end
end
