defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0) do
    raise "Error"
  end

  def nth(nth1) do
    nth(nth1, 0, 2)
  end

  def nth(nth1, curNth, cur) do
    cond do
      is_prime(cur) && nth1 == curNth + 1 -> cur
      is_prime(cur) -> nth(nth1, curNth + 1, cur + 1)
      true -> nth(nth1, curNth, cur + 1)
    end
  end

  defp is_prime(n) do
    cond do
      n <= 1 -> false
      n <= 3 -> true
      rem(n, 2) == 0 || rem(n, 3) == 0 -> false
      true -> loop(n)
    end
  end

  defp loop(n) do
    loop(5, n)
  end

  defp loop(i, n) do
    cond do
      i * i <= n && (rem(n, i) == 0 || rem(n, (i + 2)) == 0) -> false
      i * i <= n -> loop(i + 6, n)
      true -> true
    end
  end

end
