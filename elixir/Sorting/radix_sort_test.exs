Code.load_file("radix_sort.exs", __DIR__)

ExUnit.start()

defmodule RadixSortTest do
  use ExUnit.Case

  test "it returns an empty list when handed an empty list" do
    assert RadixSort.radixsort([]) === []
  end

  test "it returns a single entry list when handed a single entry list" do
    assert RadixSort.radixsort([1]) === [1]
  end

  test "it sorts single digit numbers that start in the correct order" do
    assert RadixSort.radixsort([1, 2, 3]) === [1, 2, 3]
  end

  test "it sorts single digit numbers that start in the wrong order" do
    assert RadixSort.radixsort([3, 1, 2]) === [1, 2, 3]
  end

  test "it sorts multi-digit numbers that start in the correct order" do
    assert RadixSort.radixsort([13, 21, 32]) === [13, 21, 32]
  end

  test "it sorts multi-digit numbers that start in the wrong order" do
    assert RadixSort.radixsort([21, 13, 32]) === [13, 21, 32]
  end

  test "it sorts numbers of differing digit-counts that start in the correct order" do
    assert RadixSort.radixsort([2, 15, 1001]) === [2, 15, 1001]
  end

  test "it sorts numbers of differing digit-counts that start in the wrong order" do
    assert RadixSort.radixsort([1001, 15, 2, 22]) === [2, 15, 22, 1001]
  end

  test "it sorts numbers (containing 0) of differing digit-counts that start in the wrong order" do
    assert RadixSort.radixsort([1001, 15, 0, 2, 22]) === [0, 2, 15, 22, 1001]
  end
end
