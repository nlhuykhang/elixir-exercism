defmodule BracketPush do
  @map %{
    "{" => "}",
    "(" => ")",
    "[" => "]"
  }
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.codepoints
    |> c

  end

  defp c(list) do
    c(list, [])
  end

  defp c([], stack) do
    length(stack) == 0
  end

  defp c([h | t], stack) do
    cond do
      is_open_bracket(h) ->
        c(t, stack ++ [h])
      is_close_bracket(h) ->
        process_close_bracket(t, h, stack)
      true -> c(t, stack)
    end
  end

  defp process_close_bracket(t, h, stack) do
    last = List.last(stack)
    cond do
      @map[last] == h ->
        c(t, List.delete_at(stack, -1))
      true -> c([], [1])
    end

  end

  defp is_open_bracket(x) do
    String.contains? "[{(", x
  end

  defp is_close_bracket(x) do
    String.contains? "]})", x
  end
end
