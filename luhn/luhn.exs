defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.reverse
    |> String.codepoints
    |> do_checksum(1)
  end

  defp do_checksum(list, n) do
    do_checksum(list, n, [])
  end

  defp do_checksum([], _, acc), do: Enum.sum(acc)

  defp do_checksum([h | t], cur, acc) do
    cond do
      cur == 1 -> h
        |> Integer.parse(10)
        |> (fn({n, _}) -> do_checksum(t, 2, [n | acc]) end).()
      true -> h
        |> Integer.parse(10)
        |> do_double
        |> do_check
        |> (fn(n) -> do_checksum(t, 1, [n | acc]) end).()
    end
  end

  defp do_double({n, _}), do: n * 2

  defp do_check(n) when n < 10, do: n
  defp do_check(n), do: n - 9

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> checksum
    |> do_valid
  end

  defp do_valid(n) when rem(n, 10) == 0, do: true
  defp do_valid(_), do: false

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    number
    |> String.reverse
    |> String.codepoints
    |> do_checksum(2)
    |> find_this_missing_digit
    |> get_the_prize(number)
  end

  defp find_this_missing_digit(n), do: n |> rem(10) |> subtract_by_ten

  defp subtract_by_ten(n), do: 10 - n

  defp get_the_prize(a, b) when a == 10, do: b <> "0"
  defp get_the_prize(a, b), do: b <> Integer.to_string(a)
end
