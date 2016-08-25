defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints
    |> e("", 0, "")
  end

  defp e([], "", _, re) do
    re
  end

  defp e([], c, n, re) do
    re <> to_string(n) <> c
  end

  defp e([h | t], "", _, _) do
    e(t, h, 1, "")
  end

  defp e([h | t], c, n, re) do
    cond do
      h == c -> e(t, c, n + 1, re)
      true -> e(t, h, 1, re <> to_string(n) <> c)
    end
  end

  # def e(str, c, n, re) do
  #
  # end

  @spec decode(String.t) :: String.t
  def decode(string) do
    cl = get_char_list string
    nl = get_num_list string

    d(cl, nl, [])

  end

  defp d([], [], re) do
    Enum.join re
  end

  defp d([ch | ct], [nh | nt], re) do
    d(ct, nt, re ++ List.duplicate(ch, nh))
  end

  # def d(cl, nl, re) do
  #
  # end

  defp with_out_empty(l) do
    Enum.filter(l, fn(x) -> x != "" end)
  end

  defp get_char_list(str) do
    str
    |> String.split(~r/\d/)
    |> with_out_empty
  end

  defp get_num_list(str) do
    str
    |> String.split(~r/[A-Z]/)
    |> with_out_empty
    |> Enum.map(fn(x) -> String.to_integer(x) end)
  end
end
