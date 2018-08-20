defmodule RadixSort do

	def radixsort([]), do: []

	# doesn't work for negative numbers
	def radixsort(numbers) do
		numbers
		|> get_max_digits()
		|> pad_numbers(numbers)
		|> do_sort()
	end

	def get_max_digits(numbers) do
		Enum.reduce(numbers, 0, fn n, max -> if n > max, do: n, else: max end)
	end

	"""
	@doc
	turns [1, 12, 300] into [[0, 0, 1], [0, 1, 2], [3, 0, 0]]
	"""
	def pad_numbers(pad_length, numbers) do
		numbers
		|> Enum.map(fn number -> 
			"#{number}"
			|> String.pad_leading(pad_length)
			|> String.graphemes()
			|> Enum.map(fn g -> String.to_integer(g) end)
		end)
	end

	def do_sort([head | _tail] = numbers) do
		digits = length(head)

		0..(digits - 1)	
		|> Enum.reduce(numbers, fn i, numbers -> 
			numbers
			|> put_into_buckets(digits, i)
			|> get_from_buckets()
		end)
		|> Enum.map(fn number -> number |> Enum.join())
	end

	"""
	@doc
	Sorts numbers (in the form [[0, 1, 2], [3, 0, 0]]) into buckets based on 
	"""
	def put_into_buckets(numbers, digits, index) do
		buckets =
			0..(digits - 1)
			|> # turn into hashmap with %{0 => [], 1 => [] ...}

		# put number into bucket[number[index]]
	end

	def get_from_buckets(buckets, digits) do
		0..(digits - 1)
		|> Enum.reduce([], fn i, acc ->
			buckets[i]
			|> Enum.reverse()
			|> (&Enum.concat(acc, &1)).()
		end)
	end
end
