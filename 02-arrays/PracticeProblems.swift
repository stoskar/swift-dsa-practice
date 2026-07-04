import Foundation

// ============================================
// Arrays — Mixed Practice Problems
// Day 13 — Revision of all array patterns
// ============================================
// Patterns covered:
// - Two Pointers
// - Sliding Window
// - Prefix Sum
// - Kadane's Algorithm
// - Hashing
// ============================================

// MARK: - Problem 1: Contains Duplicate
// ============================================
// Given an array, return true if any value
// appears at least twice.
//
// Example:
// Input:  [1, 2, 3, 1]
// Output: true
//
// Pattern: Hashing
// Time: O(n) | Space: O(n)
// ============================================

func containsDuplicate(_ nums: [Int]) -> Bool {
    var seen = Set<Int>()

    for num in nums {
        if seen.contains(num) { return true }
        seen.insert(num)
    }
    return false
}

// MARK: - Problem 2: Rotate Array
// ============================================
// Rotate array to the right by k steps
//
// Example:
// Input:  [1, 2, 3, 4, 5, 6, 7], k = 3
// Output: [5, 6, 7, 1, 2, 3, 4]
//
// Pattern: Two Pointers + Reverse
// Time: O(n) | Space: O(1)
// ============================================

func rotateArray(_ nums: inout [Int], k: Int) {
    let k = k % nums.count  // handle k > array length

    reverse(&nums, start: 0, end: nums.count - 1)  // reverse all
    reverse(&nums, start: 0, end: k - 1)            // reverse first k
    reverse(&nums, start: k, end: nums.count - 1)   // reverse rest
}

private func reverse(_ nums: inout [Int], start: Int, end: Int) {
    var left = start
    var right = end

    while left < right {
        nums.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - Problem 3: Max Consecutive Ones
// ============================================
// Find maximum number of consecutive 1s in array
//
// Example:
// Input:  [1, 1, 0, 1, 1, 1]
// Output: 3
//
// Pattern: Sliding Window
// Time: O(n) | Space: O(1)
// ============================================

func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var maxCount = 0
    var currentCount = 0

    for num in nums {
        if num == 1 {
            currentCount += 1
            maxCount = max(maxCount, currentCount)
        } else {
            currentCount = 0
        }
    }
    return maxCount
}

// MARK: - Problem 4: Intersection of Two Arrays
// ============================================
// Return array of unique elements in both arrays
//
// Example:
// Input:  [1, 2, 2, 1], [2, 2]
// Output: [2]
//
// Pattern: Hashing
// Time: O(n + m) | Space: O(n)
// ============================================

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    let set1 = Set(nums1)
    var result = Set<Int>()

    for num in nums2 {
        if set1.contains(num) {
            result.insert(num)
        }
    }
    return Array(result)
}

// MARK: - Problem 5: Longest Subarray with Sum K
// ============================================
// Find length of longest subarray with sum equal to k
//
// Example:
// Input:  [1, -1, 5, -2, 3], k = 3
// Output: 4  → [1, -1, 5, -2]
//
// Pattern: Prefix Sum + Hashing
// Time: O(n) | Space: O(n)
// ============================================

func longestSubarrayWithSumK(_ nums: [Int], k: Int) -> Int {
    var prefixSumMap = [Int: Int]()  // sum: first index seen
    prefixSumMap[0] = -1             // base case
    var currentSum = 0
    var maxLength = 0

    for (i, num) in nums.enumerated() {
        currentSum += num

        if let firstIndex = prefixSumMap[currentSum - k] {
            maxLength = max(maxLength, i - firstIndex)
        }

        if prefixSumMap[currentSum] == nil {
            prefixSumMap[currentSum] = i
        }
    }
    return maxLength
}

// MARK: - Problem 6: Sort Colors (Dutch National Flag)
// ============================================
// Sort array containing only 0s, 1s and 2s in-place
//
// Example:
// Input:  [2, 0, 2, 1, 1, 0]
// Output: [0, 0, 1, 1, 2, 2]
//
// Pattern: Three Pointers
// Time: O(n) | Space: O(1)
// ============================================

func sortColors(_ nums: inout [Int]) {
    var low = 0                 // boundary for 0s
    var mid = 0                 // current element
    var high = nums.count - 1   // boundary for 2s

    while mid <= high {
        switch nums[mid] {
        case 0:
