defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_job(number, 2, [])
  end

  defp do_job(0, _, re), do: re
  defp do_job(number, prime, re) do
    cond do
      rem(number, prime) == 0 -> do_job(div(number, prime), prime, re ++ [prime])
      rem(number, prime) != 0 && number < prime -> do_job(0, prime, re)
      is_prime(number) -> do_job(0, prime, re ++ [number])
      true -> do_job(number, prime + 1, re)
    end
  end

  defp is_prime(number) do
    cond do
      number <= 1 -> false
      number <= 3 -> true
      rem(number, 3) == 0 || rem(number, 2) == 0 -> false
      true -> loop(number, 5)
    end
  end

  defp loop(number, i) do
    cond do
      i * i > number -> true
      rem(number, i) == 0 || rem(number, i + 2) == 0 -> false
      true -> loop(number, i + 1)
    end
  end
end
