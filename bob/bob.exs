defmodule Bob do
  def hey(input) do
    cond do
        input
          |> String.codepoints
          |> List.last == "?" -> "Sure."
        String.trim(input) == "" -> "Fine. Be that way!"
        String.match?(~r/\D/, input) && String.upcase(input) == input -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end
end
