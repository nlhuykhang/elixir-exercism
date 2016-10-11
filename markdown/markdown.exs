defmodule Markdown do
  @word_boundaries [ strong: "__",
                     em: "_" ]

  @doc """

  """

  @spec parse(String.t) :: String.t
  def parse(markdown) do

    markdown
    |> String.split(~r/(\n|\r\n)/)
    |> replace_inline
    |> check_list

  end
  defp check_list(_, acc \\ "", options \\ [])
  defp check_list([], a, _), do: a
  defp check_list(["#" <> h|t], a, opts), do:
    check_list(t, a <> get_header("#" <> h), opts)

  defp check_list(["*" <> h|t], a, opts) do

    ## leading characters
    lc = cond do
      opts[:openlist] -> ""
      true -> "<ul>"
    end

    ## terminating characters
    tc = cond do
      String.valid?(List.first(t)) && String.starts_with?(List.first(t), "*")
       -> %{text: "", openlist: true}
      true -> %{text: "</ul>", openlist: false}
    end

    check_list( t,
      a <> lc <> "<li>#{String.trim_leading(h)}</li>" <> tc.text,
       update_in(opts, [:openlist], fn _ -> tc.openlist end))

  end

  defp check_list([h|t], a, _), do:
    check_list(t, a <> "<p>" <> h <> "</p>")

  defp get_header(str), do:
    Regex.replace(~r/(#+)\s+(.+)$/, str,
      fn(_,b,c) -> "<h#{String.length(b)}>#{c}</h#{String.length(b)}>" end)

  defp replace_inline(list) when is_list(list), do:
    list
    |> Enum.map(fn(x) ->
        x |> replace_inline
       end)

  defp replace_inline(str), do:
    Enum.reduce(@word_boundaries, str, fn({k,v}, a) ->
      a |> String.replace(~r/\b#{v}(.+)#{v}\b/, "<#{k}>\\1</#{k}>")
    end)


end


defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @filter_regex ~r/<ul>.*(?<first><\/ul>).*(?<second><ul>).*<\/ul>/

  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Stream.map(&_parse/1)
    |> Enum.join
    |> strip_redundant_tags
  end

  defp _parse(markdown) do
    markdown
    |> parse_headers
    |> parse_list
    |> parse_bold
    |> parse_italics
    |> into_paragraph
  end

  defp parse_headers(<<"# ", markdown::binary>>), do: "<h1>#{markdown}</h1>"
  defp parse_headers(<<"## ", markdown::binary>>), do: "<h2>#{markdown}</h2>"
  defp parse_headers(<<"### ", markdown::binary>>), do: "<h3>#{markdown}</h3>"
  defp parse_headers(<<"#### ", markdown::binary>>), do: "<h4>#{markdown}</h4>"
  defp parse_headers(<<"##### ", markdown::binary>>), do: "<h5>#{markdown}</h5>"
  defp parse_headers(<<"###### ", markdown::binary>>), do: "<h6>#{markdown}</h6>"
  defp parse_headers(markdown), do: markdown

  defp parse_list(<<"* ", markdown::binary>>), do: "<ul><li>#{markdown}</li></ul>"
  defp parse_list(markdown), do: markdown

  defp parse_bold(markdown) do
    markdown
    |> String.replace("__", "<strong>", global: false)
    |> String.replace("__", "</strong>")
  end

  defp parse_italics(markdown) do
    markdown
    |> String.replace("_", "<em>", global: false)
    |> String.replace("_", "</em>")
  end

  defp into_paragraph(<<"<h", markdown::binary>>), do: "<h" <> markdown
  defp into_paragraph(<<"<ul", markdown::binary>>), do: "<ul" <> markdown
  defp into_paragraph(<<markdown, "ul>">>), do: markdown <> "ul>"
  defp into_paragraph(markdown), do: "<p>#{markdown}</p>"

  defp strip_redundant_tags(markdown) do
    @filter_regex
    |> Regex.split(markdown, on: [:first, :second])
    |> Enum.join
  end
end
