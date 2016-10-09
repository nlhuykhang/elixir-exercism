defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    cond do
      is_valid(string) -> convert(string)
      true -> 0
    end
  end

  defp is_valid(str) do
    !Regex.match?(~r/[^01]/, str)
  end

  defp convert(str) do
    str
    |> String.codepoints
    |> Enum.reverse
    |> do_convert
  end

  defp do_convert(list) do
    do_convert(list, 1, 0)
  end

  defp do_convert([], _, acc) do
    acc
  end

  defp do_convert([h | t], cur, acc) do
    cond do
      h == "0" -> do_convert(t, cur * 2, acc)
      true -> do_convert(t, cur * 2, acc + cur)
    end
  end
end
