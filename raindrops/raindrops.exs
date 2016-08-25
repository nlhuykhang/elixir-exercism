defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    {"", number}
    |> div3
    |> div5
    |> div7
    |> finalize

  end

  def div3({str, number}) do
    cond do
      rem(number, 3) == 0 -> {str <> "Pling", div(number, 3)}
      true -> {str, number}
    end
  end

  def div5({str, number}) do
    cond do
      rem(number, 5) == 0 -> {str <> "Plang", div(number, 5)}
      true -> {str, number}
    end
  end

  def div7({str, number}) do
    cond do
      rem(number, 7) == 0 -> {str <> "Plong", div(number, 7)}
      true -> {str, number}
    end
  end

  def finalize({str, number}) do
    cond do
      String.length(str) > 0 -> str
      true -> to_string number
    end
  end
end
