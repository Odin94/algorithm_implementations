defmodule RadixSort do
  def radixsort([]), do: []

  @doc """
  Sort a list of non-negative integers
  Time O(n+m)
  Space O(n+k)
  Where m is the maximum number of digits among input numbers
  and k is.. something related to m, I think. Not actually sure '_>'
    Best guess: We always keep an array of length n and m buckets of length[0..n] - should be pretty close to O(n+m) 
  """
  def radixsort(numbers) do
    numbers
    |> get_max_digit_count()
    |> pad_numbers(numbers)
    |> do_sort()
  end

  def get_max_digit_count(numbers) do
    Enum.reduce(numbers, 0, fn n, max ->
      digit_count = "#{n}" |> String.length()
      if digit_count > max, do: digit_count, else: max
    end)
  end

  @doc """
  turns [1, 12, 300] into [[0, 0, 1], [0, 1, 2], [3, 0, 0]]
  """

  defp pad_numbers(pad_length, numbers) do
    numbers
    |> Enum.map(fn number ->
      "#{number}"
      |> String.pad_leading(pad_length, "0")
      |> String.graphemes()
      |> Enum.map(fn g -> String.to_integer(g) end)
    end)
  end

  defp do_sort([head | _tail] = numbers) do
    digit_count = length(head)

    (digit_count - 1)..0
    |> Enum.reduce(numbers, fn i, numbers ->
      numbers
      |> put_into_buckets(i)
      |> get_from_buckets()
    end)
    |> Enum.map(fn number -> number |> Enum.join() |> String.to_integer() end)
  end

  @doc """
  Sorts numbers (in the form [[0, 1, 2], [3, 0, 0]]) into buckets based on
  """
  defp put_into_buckets(numbers, index) do
    numbers
    |> Enum.reduce(get_empty_buckets(), fn number, buckets ->
      Map.update!(buckets, Enum.at(number, index), fn bucket_list -> [number | bucket_list] end)
    end)
  end

  defp get_empty_buckets(amount \\ 10) do
    0..(amount - 1)
    |> Enum.reduce(%{}, fn i, buckets -> Map.put(buckets, i, []) end)
  end

  defp get_from_buckets(buckets, amount \\ 10) do
    0..(amount - 1)
    |> Enum.reduce([], fn i, acc ->
      buckets[i]
      |> Enum.reverse()
      |> (&Enum.concat(acc, &1)).()

      # |> Enum.reverse()
    end)
  end
end
