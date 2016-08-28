defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do

    {_, normalized_base} = normalize_string base

    candidates
    |> Enum.map(fn(x) -> normalize_string(x) end)
    |> Enum.filter(
      fn({x, y}) ->
        y == normalized_base &&
        String.downcase(x) != String.downcase(base)
      end
    )
    |> Enum.map(fn({x, _}) -> x end)

  end

  defp normalize_string(x) do
    x
    |> String.downcase
    |> String.codepoints
    |> Enum.sort
    |> List.to_string
    |> (
      fn(r) -> {x, r} end
    ).()
  end
end
