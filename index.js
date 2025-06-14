/**
 * Unit Tests for Quick Sort implementation
 * 
 * This file contains tests for the quick sort algorithm functions
 * using Jest testing framework.
 */

// Import the functions to test
const { quickSort, partition, swap } = require('./quickSort');

describe('Swap Function', () => {
  test('swaps two elements in an array', () => {
    const arr = [1, 2, 3, 4, 5];
    swap(arr, 0, 4);
    expect(arr).toEqual([5, 2, 3, 4, 1]);
  });

  test('handles swapping an element with itself', () => {
    const arr = [1, 2, 3];
    swap(arr, 1, 1);
    expect(arr).toEqual([1, 2, 3]);
  });

  test('works with arrays of different data types', () => {
    const arr = [1, 'two', { three: 3 }];
    swap(arr, 0, 2);
    expect(arr).toEqual([{ three: 3 }, 'two', 1]);
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
