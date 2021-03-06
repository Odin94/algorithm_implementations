Code.load_file("counting_sort.exs", __DIR__)

ExUnit.start()

# Note: lazily copied tests from radix sort
defmodule CountingSortTest do
  use ExUnit.Case

  describe "tests for unstable version" do
    test "it returns an empty list when handed an empty list" do
      assert CountingSort.counting_sort([]) === []
    end

    test "it returns a single entry list when handed a single entry list" do
      assert CountingSort.counting_sort([1]) === [1]
    end

    test "it sorts single digit numbers that start in the correct order" do
      assert CountingSort.counting_sort([1, 2, 3]) === [1, 2, 3]
    end

    test "it sorts single digit numbers that start in the wrong order" do
      assert CountingSort.counting_sort([3, 1, 2]) === [1, 2, 3]
    end

    test "it sorts multi-digit numbers that start in the correct order" do
      assert CountingSort.counting_sort([13, 21, 32]) === [13, 21, 32]
    end

    test "it sorts multi-digit numbers that start in the wrong order" do
      assert CountingSort.counting_sort([21, 13, 32]) === [13, 21, 32]
    end

    test "it sorts numbers of differing digit-counts that start in the correct order" do
      assert CountingSort.counting_sort([2, 15, 1001]) === [2, 15, 1001]
    end

    test "it sorts numbers of differing digit-counts that start in the wrong order" do
      assert CountingSort.counting_sort([1001, 15, 2, 22]) === [2, 15, 22, 1001]
    end

    test "it sorts numbers (containing 0) of differing digit-counts that start in the wrong order" do
      assert CountingSort.counting_sort([1001, 15, 0, 2, 22]) === [0, 2, 15, 22, 1001]
    end
  end

  describe "Tests for stable version" do
    test "(stable) it returns an empty list when handed an empty list" do
      assert CountingSort.counting_sort_stable([]) === []
    end

    test "(stable) it returns a single entry list when handed a single entry list" do
      assert CountingSort.counting_sort_stable([1]) === [1]
    end

    test "(stable) it sorts single digit numbers that start in the correct order" do
      assert CountingSort.counting_sort_stable([1, 2, 3]) === [1, 2, 3]
    end

    test "(stable) it sorts single digit numbers that start in the wrong order" do
      assert CountingSort.counting_sort_stable([3, 1, 2]) === [1, 2, 3]
    end

    test "(stable) it sorts multi-digit numbers that start in the correct order" do
      assert CountingSort.counting_sort_stable([13, 21, 32]) === [13, 21, 32]
    end

    test "(stable) it sorts multi-digit numbers that start in the wrong order" do
      assert CountingSort.counting_sort_stable([21, 13, 32]) === [13, 21, 32]
    end

    test "(stable) it sorts numbers of differing digit-counts that start in the correct order" do
      assert CountingSort.counting_sort_stable([2, 15, 1001]) === [2, 15, 1001]
    end

    test "(stable) it sorts numbers of differing digit-counts that start in the wrong order" do
      assert CountingSort.counting_sort_stable([1001, 15, 2, 22]) === [2, 15, 22, 1001]
    end

    test "(stable) it sorts numbers (containing 0) of differing digit-counts that start in the wrong order" do
      assert CountingSort.counting_sort_stable([1001, 15, 0, 2, 22]) === [0, 2, 15, 22, 1001]
    end
  end
end
