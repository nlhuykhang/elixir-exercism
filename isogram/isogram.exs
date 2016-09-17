defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    norm_sentence = normalize(sentence)

    String.length(norm_sentence) == uniq_length(norm_sentence)
  end

  defp normalize(sentence) do
    Regex.replace(~r/([^\w]|_)/u, sentence, "")
  end

  defp uniq_length(sentence) do
    sentence
    |> String.codepoints
    |> Enum.uniq
    |> length
  end

end


Regex.replace(~r/([^\w]|_)/, "heizölrückstoßabdämpfung", "")
