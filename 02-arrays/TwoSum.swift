import Foundation

// ============================================
// Problem: Two Sum
// ============================================
// Given an array of integers and a target sum,
// return indices of two numbers that add up to target.
//
// Example:
// Input:  [2, 7, 11, 15], target = 9
// Output: [0, 1]  because 2 + 7 = 9
//
// Constraints:
// - Exactly one solution exists
// - Cannot use same element twice
// ============================================

// MARK: - Approach 1: Brute Force
// Check every pair of numbers
// Time: O(n²) | Space: O(1)

func twoSumBrute(_ nums: [Int], target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i + 1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}

// MARK: - Approach 2: Hash Map (Optimal)
// Store visited numbers in dictionary
// Time: O(n) | Space: O(n)

func twoSumOptimal(_ nums: [Int], target: Int) -> [Int] {
    var seen = [Int: Int]()  // value: index

    for (index, num) in nums.enumerated() {
        let complement = target - num

        if let complementIndex = seen[complement] {
            return [complementIndex, index]
        }

        seen[num] = index
    }
    return []
}

// MARK: - Test Cases

let nums1 = [2, 7, 11, 15]
print(twoSumOptimal(nums1, target: 9))   // [0, 1]

let nums2 = [3, 2, 4]
print(twoSumOptimal(nums2, target: 6))   // [1, 2]

let nums3 = [3, 3]
print(twoSumOptimal(nums3, target: 6))   // [0, 1]

// MARK: - Complexity Analysis
/*
 Brute Force:
   Time  → O(n²) — nested loops check every pair
   Space → O(1)  — no extra memory

 Hash Map (Optimal):
   Time  → O(n)  — single pass through array
   Space → O(n)  — dictionary stores up to n elements

 Key Insight:
 For each number, we need its complement (target - num).
 Instead of searching for it (O(n)), store seen numbers
 in a dictionary for O(1) lookup.
*/
