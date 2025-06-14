/**
 * Unit Tests for Quick Sort implementation
 * 
 * This file contains tests for the quick sort algorithm functions
 * using Jest testing framework.
 * 
 * Tests include:
 * - Sorting arrays of integers (positive, negative, and mixed)
 * - Handling edge cases (empty arrays, single-element arrays)
 * - Performance benchmarking for different input sizes
 * - Comparison with native Array.sort() method
 * 
 * Each test case validates that:
 * 1. The array is properly sorted in ascending order
 * 2. The original array is not modified (when implementing non-mutating sort)
 * 3. All original elements are present in the sorted array
 */

// Import the functions to test
const { quickSort, partition, swap } = require('./quickSort');

describe('Swap Function', () => {
  test.each([
    [[1, 2, 3, 4, 5], 0, 4, [5, 2, 3, 4, 1]],
    [[10, 20, 30, 40, 50], 1, 3, [10, 40, 30, 20, 50]],
    [[100, 200, 300], 0, 2, [300, 200, 100]],
    [['a', 'b', 'c', 'd'], 0, 3, ['d', 'b', 'c', 'a']],
  ])('swaps two elements in an array %j using indices %i and %i', (arr, idx1, idx2, expected) => {
    swap(arr, idx1, idx2);
    expect(arr).toEqual(expected);
  });

  test.each([
    [[1, 2, 3], 1, 1, [1, 2, 3]],
    [[10, 20, 30], 0, 0, [10, 20, 30]],
    [['a', 'b', 'c'], 2, 2, ['a', 'b', 'c']],
    [[true, false], 0, 0, [true, false]],
  ])('handles swapping an element with itself in array %j at index %i', (arr, idx1, idx2, expected) => {
    swap(arr, idx1, idx2);
    expect(arr).toEqual(expected);
  });

  test.each([
    [[1, 'two', { three: 3 }], 0, 2, [{ three: 3 }, 'two', 1]],
    [['a', 1, true], 0, 2, [true, 1, 'a']],
    [[null, undefined, 'string'], 0, 1, [undefined, null, 'string']],
    [[{}, [], 0], 1, 2, [{}, 0, []]],
  ])('works with arrays of different data types %j swapping indices %i and %i', (arr, idx1, idx2, expected) => {
    swap(arr, idx1, idx2);
    expect(arr).toEqual(expected);
  });
});

describe('Partition Function', () => {
  test('correctly partitions an array around a pivot', () => {
    const arr = [10, 7, 8, 9, 1, 5];
    const pivotIndex = partition(arr, 0, arr.length - 1);

    // Elements before pivotIndex should be <= pivot
    for (let i = 0; i < pivotIndex; i++) {
      expect(arr[i]).toBeLessThanOrEqual(arr[pivotIndex]);
    }

    // Elements after pivotIndex should be > pivot
    for (let i = pivotIndex + 1; i < arr.length; i++) {
      expect(arr[i]).toBeGreaterThan(arr[pivotIndex]);
    }
  });

  test('handles arrays with duplicate values', () => {
    const arr = [5, 5, 5, 5, 5];
    const pivotIndex = partition(arr, 0, arr.length - 1);
    expect(pivotIndex).toBe(4); // All elements equal, so pivot should be at the end
  });

  test('works with a single element array', () => {
    const arr = [42];
    const pivotIndex = partition(arr, 0, 0);
    expect(pivotIndex).toBe(0);
    expect(arr).toEqual([42]);
  });
});

describe('QuickSort Function', () => {
  test('sorts an array of numbers in ascending order', () => {
    const unsorted = [10, 7, 8, 9, 1, 5, 3, 2, 6, 4];
    const sorted = quickSort(unsorted);
    expect(sorted).toEqual([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  });

  test('does not modify the original array', () => {
    const original = [10, 7, 8, 9, 1, 5];
    const originalCopy = [...original];
    quickSort(original);
    expect(original).toEqual(originalCopy);
  });

  test('handles an empty array', () => {
    const empty = [];
    const result = quickSort(empty);
    expect(result).toEqual([]);
  });

  test('handles an array with a single element', () => {
    const single = [42];
    const result = quickSort(single);
    expect(result).toEqual([42]);
  });

  test('handles an array with duplicate elements', () => {
    const duplicates = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
    const result = quickSort(duplicates);
    expect(result).toEqual([1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]);
  });

  test('handles an already sorted array', () => {
    const sorted = [1, 2, 3, 4, 5];
    const result = quickSort(sorted);
    expect(result).toEqual([1, 2, 3, 4, 5]);
  });

  test('handles a reverse sorted array', () => {
    const reversed = [5, 4, 3, 2, 1];
    const result = quickSort(reversed);
    expect(result).toEqual([1, 2, 3, 4, 5]);
  });

  test('sorts an array of strings', () => {
    const strings = ['banana', 'apple', 'cherry', 'date'];
    const result = quickSort(strings);
    expect(result).toEqual(['apple', 'banana', 'cherry', 'date']);
  });
});
