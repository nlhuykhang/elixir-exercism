defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    cond do
      length(strand1) == length(strand2) -> epic(strand1, strand2)
      true -> {:error, "Lists must be the same length"}
    end
  end

  defp epic(s1, s2) do
    epic(s1, s2, 0)
  end

  defp epic([], [], count) do
    {:ok, count}
  end

  defp epic([h1 | t1], [h2 | t2], count) do
    cond do
      h1 == h2 -> epic(t1, t2, count)
      true -> epic(t1, t2, count + 1)
    end
  end
end
