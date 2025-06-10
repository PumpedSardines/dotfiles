/**
 * Quick Sort implementation in JavaScript
 * 
 * This file contains an implementation of the quick sort algorithm,
 * which is an efficient, comparison-based sorting algorithm.
 */

/**
 * Swaps two elements in an array
 * @param {Array} arr - The array containing elements to swap
 * @param {Number} i - Index of first element
 * @param {Number} j - Index of second element
 */
function swap(arr, i, j) {
  const temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/**
 * Partitions the array around a pivot element
 * @param {Array} arr - The array to partition
 * @param {Number} low - Starting index
 * @param {Number} high - Ending index
 * @returns {Number} - The partition index
 */
function partition(arr, low, high) {
  // Using the last element as the pivot
  const pivot = arr[high];
  
  // Index of smaller element
  let i = low - 1;
  
  for (let j = low; j < high; j++) {
    // If current element is smaller than or equal to pivot
    if (arr[j] <= pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  
  // Place pivot in its correct position
  swap(arr, i + 1, high);
  
  // Return the partition index
  return i + 1;
}

/**
 * Recursive implementation of quick sort
 * @param {Array} arr - The array to sort
 * @param {Number} low - Starting index
 * @param {Number} high - Ending index
 */
function quickSortRecursive(arr, low, high) {
  if (low < high) {
    // Find the partition index
    const partitionIndex = partition(arr, low, high);
    
    // Recursively sort elements before and after partition
    quickSortRecursive(arr, low, partitionIndex - 1);
    quickSortRecursive(arr, partitionIndex + 1, high);
  }
}

/**
 * Main quick sort function
 * @param {Array} arr - The array to sort
 * @returns {Array} - The sorted array
 */
function quickSort(arr) {
  // Create a copy to avoid modifying the original array
  const result = [...arr];
  
  // Call the recursive implementation
  quickSortRecursive(result, 0, result.length - 1);
  
  return result;
}

// Example usage
function example() {
  const unsortedArray = [10, 7, 8, 9, 1, 5, 3, 2, 6, 4];
  console.log("Unsorted array:", unsortedArray);
  
  const sortedArray = quickSort(unsortedArray);
  console.log("Sorted array:", sortedArray);
  
  // Original array remains unchanged
  console.log("Original array:", unsortedArray);
}

// Uncomment to run the example
// example();

module.exports = {
  quickSort,
  partition,
  swap
};

