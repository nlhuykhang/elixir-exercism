defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @spec count([char], char) :: non_neg_integer

  def count(strand, nucleotide) do
    if !Enum.member?(@nucleotides, nucleotide) do
      raise ArgumentError
    end

    strand
      |> Enum.each(
        fn(x) ->
          if !Enum.member?(@nucleotides, x) do
            raise ArgumentError
          end
        end
      )

    strand
      |> Enum.filter(fn(x) -> x == nucleotide end)
      |> length
  end

  @spec histogram([char]) :: map
  def histogram(strand) do
    %{
      ?A => count(strand, ?A),
      ?T => count(strand, ?T),
      ?C => count(strand, ?C),
      ?G => count(strand, ?G)
    }
  end
end
