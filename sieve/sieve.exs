defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    do_job(2, limit, [], [])
  end

  defp do_job(cur, limit, prime_list, _) when cur > limit, do: prime_list
  defp do_job(cur, limit, prime_list, not_prime_list) do
    cond do
      Enum.member?(not_prime_list, cur) -> do_job(cur + 1, limit, prime_list, not_prime_list ++ [cur])
      true -> do_job(cur + 1, limit, prime_list ++ [cur], not_prime_list ++ get_multiples(cur, cur, limit, []))
    end
  end

  defp get_multiples(base, cur, limit, acc) when cur > limit, do: acc
  defp get_multiples(base, cur, limit, acc), do: get_multiples(base, cur + base, limit, acc ++ [cur])

end
