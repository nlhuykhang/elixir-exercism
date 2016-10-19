defmodule Hexadecimal do
  @hex_to_decimal %{
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "a" => 10,
    "b" => 11,
    "c" => 12,
    "d" => 13,
    "e" => 14,
    "f" => 15
  }
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    cond do
      is_valid?(hex) -> do_convert(hex)
      true -> 0
    end
  end

  defp do_convert(hex) do
    hex
    |> String.downcase
    |> String.reverse
    |> String.codepoints
    |> do_convert(0, 0)
  end

  defp do_convert([], _, acc), do: acc

  defp do_convert([h | t], index, acc), do: do_convert(t, index + 1, acc + @hex_to_decimal[h] * :math.pow(16, index))

  defp is_valid?(hex), do: !Regex.match?(~r/[^0123456789abcdef]/i, hex)
end
