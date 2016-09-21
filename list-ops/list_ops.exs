defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    p_count(l, 0)
  end

  defp p_count([], count) do
    count
  end

  defp p_count([ _ | t ], count) do
    p_count(t, count + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], re) do
    re
  end

  defp do_reverse([h | t], re) do
    do_reverse(t, [h | re])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f)
  end

  defp do_map([], _) do
    []
  end

  defp do_map([h | t], f) do
    [f.(h) | do_map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, []) |> reverse
  end

  defp do_filter([], _, re) do
    re
  end

  defp do_filter([h | t], f, re) do
    cond do
      f.(h) == true -> do_filter(t, f, [h | re])
      true -> do_filter(t, f, re)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _) do
    acc
  end

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reversed_a = reverse(a)
    do_append(reversed_a, b)
  end

  defp do_append([], b) do
    b
  end

  defp do_append([h | t], b) do
    do_append(t, [h | b])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    # do_concat(ll)
    reduce(ll, [], &(append(&2, &1)))
  end
end



# this version produce better performance, though it is not tail optimization
# @spec count(list) :: non_neg_integer
# def count([]), do: 0
# def count([_ | tail]), do: 1 + count(tail)
#
#
# @spec reverse(list) :: list
# defp acc_reverse([], acc), do: acc
# defp acc_reverse([head | tail], acc), do: acc_reverse(tail, [head | acc])
# def reverse(l), do: acc_reverse(l, [])
#
#
# @spec map(list, (any -> any)) :: list
# def map([], _f), do: []
# def map([head | tail], f), do: [f.(head) | map(tail, f)]
#
#
# @spec filter(list, (any -> as_boolean(term))) :: list
# def filter([], _f), do: []
# def filter([head | tail], f) do
#   if f.(head) do
#     [head | filter(tail, f)]
#   else
#     filter(tail, f)
#   end
# end
#
# @type acc :: any
# @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
# def reduce([], acc, _f), do: acc
# def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)
#
#
# @spec append(list, list) :: list
# def append([], []), do: []
# def append([], [head | tail]), do: [head | tail]
# def append([head | tail], l), do: [head | append(tail, l)]
#
#
# @spec concat([[any]]) :: [any]
# def concat([]), do: []
# def concat([head_list | tail]), do: append(head_list, concat(tail))
