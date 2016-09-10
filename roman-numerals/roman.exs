defmodule Roman do
  @map %{
    1 => "I",
    2 => "II",
    3 => "III",
    4 => "IV",
    5 => "V",
    6 => "VI",
    7 => "VII",
    8 => "VIII",
    9 => "IX",

    10 => "X",
    20 => "XX",
    30 => "XXX",
    40 => "XL",
    50 => "L",
    60 => "LX",
    70 => "LXX",
    80 => "LXXX",
    90 => "XC",

    100 => "C",
    200 => "CC",
    300 => "CCC",
    400 => "CD",
    500 => "D",
    600 => "DC",
    700 => "DCC",
    800 => "DCCC",
    900 => "CM",
    1000 => "M",

    2000 => "MM",
    3000 => "MMM"
  }
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    number
    |> life_suck
    |> Enum.map(fn(x) -> @map[x] end)
    |> Enum.join
  end

  defp life_suck(number) do
    life_suck(number, [])
  end

  defp life_suck(0, list) do
    list
  end

  defp life_suck(number, list) do
    cond do
      number >= 1000 ->
        re = rem(number, 1000)
        life_suck(re, list ++ [number - re])
      number >= 100 ->
        re = rem(number, 100)
        life_suck(re, list ++ [number - re])
      number >= 10 ->
        re = rem(number, 10)
        life_suck(re, list ++ [number - re])
      true ->
        life_suck(0, list ++ [number])
    end
  end

end
