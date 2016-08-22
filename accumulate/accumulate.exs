defmodule Accumulate do

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, _, acc \\ [])

  def accumulate([], _, acc) do
    acc
  end

  def accumulate([head | tail], fun, acc) do
    accumulate(tail, fun, acc ++ [fun.(head)])
  end

end
