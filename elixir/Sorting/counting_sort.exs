defmodule CountingSort do
  @doc """
  Sort a list of non-negative integers
  Time O(n+k)  [actually O(n + k * log(k)) because of map access time]
  Space O(n+k)
  Where k is a number such that all keys are in range 0..k

  Note: this implementation is flawed since Elixir doesn't offer
  an array datastructure with index-based constant access time.
  As a result, we give up the stable property in favor of achieving a
  good runtime by not copying the values from the unsorted array over to
  a sorted array, but just building the sorted array directly from the count.
  Ofc that also breaks aplicability for non-number input that can be mapped to non-neg numbers
  but I'm just having fun here, so I'll accept that drawback.
  """
  def counting_sort([]), do: []

  def counting_sort(numbers) do
    k = Enum.max(numbers)

    numbers
    |> count_key_frequencies()
    |> build_sorted_list(k)
    |> List.flatten()
    |> Enum.reverse()
  end

  defp count_key_frequencies(numbers),
    do: Enum.reduce(numbers, %{}, fn n, acc -> Map.update(acc, n, 1, &(&1 + 1)) end)

  defp build_sorted_list(key_frequencies, k) do
    0..k
    |> Enum.reduce([], fn i, acc ->
      case Map.get(key_frequencies, i) do
        nil -> acc
        0 -> acc
        count -> [i |> List.duplicate(count) | acc]
      end
    end)
  end

  @doc """
  Adjusted counting sort (still not original one) that efficiently creates a stable
  sorted list by copying entries from the original list into a map and copying
  from that map into a sorted list
  """
  def counting_sort_stable([]), do: []

  def counting_sort_stable(numbers) do
    k = Enum.max(numbers)

    numbers
    |> count_key_frequencies_stable()
    |> build_sorted_list_stable(k)
    |> List.flatten()
    |> Enum.reverse()
  end

  defp count_key_frequencies_stable(numbers),
    do: Enum.reduce(numbers, %{}, fn n, acc -> Map.update(acc, n, [n], &[n | &1]) end)

  defp build_sorted_list_stable(key_frequencies, k) do
    0..k
    |> Enum.reduce([], fn i, acc ->
      case Map.get(key_frequencies, i) do
        nil -> acc
        entries -> [entries | acc]
      end
    end)
  end
end
