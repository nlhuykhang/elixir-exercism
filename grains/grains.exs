defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    do_square(number - 1, 1)
  end

  defp do_square(0, re) do
    re
  end

  defp do_square(cur, re) do
    do_square(cur - 1, re * 2)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    do_total(63, 1, 0)
  end

  defp do_total(0, re1, re2) do
    re1 + re2
  end

  defp do_total(number, re1, re2) do
    do_total(number - 1, re1 * 2, re2 + re1)
  end
end
