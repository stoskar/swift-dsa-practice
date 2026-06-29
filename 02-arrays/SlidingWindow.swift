import Foundation

// ============================================
// Sliding Window Technique
// ============================================
// Used when we need to find a subarray or substring
// that satisfies a condition.
//
// Instead of recalculating the whole window each time,
// we SLIDE it forward — adding one element and
// removing one element at a time.
//
// Time: O(n) instead of O(n²) brute force
// ============================================

// MARK: - Problem 1: Max Sum Subarray of Size K
// ============================================
// Find the maximum sum of any contiguous subarray of size k
//
// Example:
// Input:  [2, 1, 5, 1, 3, 2], k = 3
// Output: 9  → subarray [5, 1, 3]
// ============================================

// Brute Force
// Time: O(n*k) | Space: O(1)
func maxSumSubarrayBrute(_ nums: [Int], k: Int) -> Int {
    var maxSum = Int.min

    for i in 0...(nums.count - k) {
        var windowSum = 0
        for j in i..<(i + k) {
            windowSum += nums[j]
        }
        maxSum = max(maxSum, windowSum)
    }
    return maxSum
}

// Sliding Window (Optimal)
// Time: O(n) | Space: O(1)
func maxSumSubarraySliding(_ nums: [Int], k: Int) -> Int {
    var windowSum = 0
    var maxSum = Int.min

    // Build first window
    for i in 0..<k {
        windowSum += nums[i]
    }
    maxSum = windowSum

    // Slide window forward
    for i in k..<nums.count {
        windowSum += nums[i]        // add new element
        windowSum -= nums[i - k]    // remove old element
        maxSum = max(maxSum, windowSum)
    }
    return maxSum
}

// MARK: - Problem 2: Smallest Subarray with Sum >= Target
// ============================================
// Find length of smallest contiguous subarray
// whose sum is >= target
//
// Example:
// Input:  [2, 1, 5, 2, 3, 2], target = 7
// Output: 2  → subarray [5, 2]
// ============================================

// Dynamic Sliding Window
// Time: O(n) | Space: O(1)
func smallestSubarrayWithSum(_ nums: [Int], target: Int) -> Int {
    var windowSum = 0
    var minLength = Int.max
    var windowStart = 0

    for windowEnd in 0..<nums.count {
        windowSum += nums[windowEnd]    // expand window

        // Shrink window from left while condition is met
        while windowSum >= target {
            let windowLength = windowEnd - windowStart + 1
            minLength = min(minLength, windowLength)
            windowSum -= nums[windowStart]  // remove left element
            windowStart += 1                // shrink window
        }
    }
    return minLength == Int.max ? 0 : minLength
}

// MARK: - Problem 3: Longest Subarray with Sum <= K
// ============================================
// Find the longest subarray where sum is <= k
//
// Example:
// Input:  [3, 1, 2, 1, 1, 3], k = 5
// Output: 4  → subarray [1, 2, 1, 1]
// ============================================

// Dynamic Sliding Window
// Time: O(n) | Space: O(1)
func longestSubarrayWithSumAtMostK(_ nums: [Int], k: Int) -> Int {
    var windowSum = 0
    var maxLength = 0
    var windowStart = 0

    for windowEnd in 0..<nums.count {
        windowSum += nums[windowEnd]    // expand window

        // Shrink window if sum exceeds k
        while windowSum > k {
            windowSum -= nums[windowStart]
            windowStart += 1
        }

        // Update max length
        maxLength = max(maxLength, windowEnd - windowStart + 1)
    }
    return maxLength
}

// MARK: - Problem 4: Max Average Subarray of Size K
// ============================================
// Find the maximum average of any subarray of size k
//
// Example:
// Input:  [1, 12, -5, -6, 50, 3], k = 4
// Output: 12.75  → subarray [12, -5, -6, 50] / 4
// ============================================

// Time: O(n) | Space: O(1)
func maxAverageSubarray(_ nums: [Int], k: Int) -> Double {
    var windowSum = 0

    // Build first window
    for i in 0..<k {
        windowSum += nums[i]
    }

    var maxSum = windowSum

    // Slide window
    for i in k..<nums.count {
        windowSum += nums[i]
        windowSum -= nums[i - k]
        maxSum = max(maxSum, windowSum)
    }

    return Double(maxSum) / Double(k)
}

// MARK: - Test Cases

// Problem 1
let nums1 = [2, 1, 5, 1, 3, 2]
print(maxSumSubarraySliding(nums1, k: 3))   // 9

// Problem 2
let nums2 = [2, 1, 5, 2, 3, 2]
print(smallestSubarrayWithSum(nums2, target: 7))  // 2

// Problem 3
let nums3 = [3, 1, 2, 1, 1, 3]
print(longestSubarrayWithSumAtMostK(nums3, k: 5))  // 4

// Problem 4
let nums4 = [1, 12, -5, -6, 50, 3]
print(maxAverageSubarray(nums4, k: 4))   // 12.75

// MARK: - Complexity Analysis
/*
 Fixed Sliding Window (size k):
   Time  → O(n)  — single pass
   Space → O(1)  — only variables

 Dynamic Sliding Window (variable size):
   Time  → O(n)  — each element added/removed once
   Space → O(1)  — only variables

 Key Insight:
 Fixed window   → slide forward removing left, adding right
 Dynamic window → expand right until condition breaks,
                  then shrink left until condition is met

 When to use Sliding Window:
  - Contiguous subarray or substring problems
  - "Maximum/minimum length" problems
  - "Sum equals/greater/less than k" problems
  - When brute force is O(n²) and you want O(n)
*/
