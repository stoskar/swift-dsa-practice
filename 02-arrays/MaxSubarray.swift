import Foundation

// ============================================
// Problem: Maximum Subarray
// ============================================
// Given an integer array, find the contiguous
// subarray with the largest sum and return its sum.
//
// Example:
// Input:  [-2, 1, -3, 4, -1, 2, 1, -5, 4]
// Output: 6  → subarray [4, -1, 2, 1]
//
// Constraints:
// - Array has at least one element
// - Can contain negative numbers
// ============================================

// MARK: - Approach 1: Brute Force
// Check sum of every possible subarray
// Time: O(n²) | Space: O(1)

func maxSubarrayBrute(_ nums: [Int]) -> Int {
    var maxSum = Int.min

    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            maxSum = max(maxSum, currentSum)
        }
    }
    return maxSum
}

// MARK: - Approach 2: Kadane's Algorithm (Optimal)
// At each element decide: extend current subarray OR start fresh
// Time: O(n) | Space: O(1)

func maxSubarrayKadane(_ nums: [Int]) -> Int {
    var maxSum = nums[0]
    var currentSum = nums[0]

    for i in 1..<nums.count {
        // Either extend current subarray or start new one
        currentSum = max(nums[i], currentSum + nums[i])
        maxSum = max(maxSum, currentSum)
    }
    return maxSum
}

// MARK: - Approach 3: Kadane's with Subarray Indices
// Same algorithm but also tracks start and end index
// Time: O(n) | Space: O(1)

func maxSubarrayWithIndices(_ nums: [Int]) -> (sum: Int, start: Int, end: Int) {
    var maxSum = nums[0]
    var currentSum = nums[0]
    var start = 0
    var end = 0
    var tempStart = 0

    for i in 1..<nums.count {
        if nums[i] > currentSum + nums[i] {
            currentSum = nums[i]
            tempStart = i       // potential new start
        } else {
            currentSum += nums[i]
        }

        if currentSum > maxSum {
            maxSum = currentSum
            start = tempStart   // confirm new start
            end = i             // update end
        }
    }
    return (maxSum, start, end)
}

// MARK: - Test Cases

let nums1 = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
print(maxSubarrayKadane(nums1))          // 6

let nums2 = [1]
print(maxSubarrayKadane(nums2))          // 1

let nums3 = [5, 4, -1, 7, 8]
print(maxSubarrayKadane(nums3))          // 23

let nums4 = [-1, -2, -3, -4]
print(maxSubarrayKadane(nums4))          // -1 (least negative)

let result = maxSubarrayWithIndices(nums1)
print("Sum: \(result.sum), Start: \(result.start), End: \(result.end)")
// Sum: 6, Start: 3, End: 6 → [4, -1, 2, 1]

// MARK: - Complexity Analysis
/*
 Brute Force:
   Time  → O(n²) — check every subarray
   Space → O(1)  — no extra memory

 Kadane's Algorithm:
   Time  → O(n)  — single pass through array
   Space → O(1)  — only two variables

 Key Insight:
 At every position ask: "Is it better to start fresh
 from this element OR extend the previous subarray?"

 currentSum = max(nums[i], currentSum + nums[i])

 If currentSum goes negative → always better to start fresh
 because a negative prefix can only hurt future sums.
*/
