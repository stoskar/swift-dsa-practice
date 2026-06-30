import Foundation

// ============================================
// Two Pointers Technique
// ============================================
// Used mainly on SORTED arrays (or when we need to
// compare elements from both ends / different positions).
//
// Two indices move toward each other or in the same
// direction to avoid nested loops.
//
// Time: O(n) instead of O(n²) brute force
// ============================================

// MARK: - Problem 1: Pair with Target Sum (Sorted Array)
// ============================================
// Given a SORTED array, find a pair that sums to target
//
// Example:
// Input:  [1, 2, 3, 4, 6], target = 6
// Output: [1, 3]  → indices of 2 and 4
// ============================================

// Time: O(n) | Space: O(1)
func pairWithTargetSum(_ nums: [Int], target: Int) -> [Int] {
    var left = 0
    var right = nums.count - 1

    while left < right {
        let currentSum = nums[left] + nums[right]

        if currentSum == target {
            return [left, right]
        } else if currentSum < target {
            left += 1       // need bigger sum → move left forward
        } else {
            right -= 1      // need smaller sum → move right backward
        }
    }
    return []
}

// MARK: - Problem 2: Remove Duplicates from Sorted Array
// ============================================
// Remove duplicates in-place, return count of unique elements
//
// Example:
// Input:  [2, 3, 3, 3, 6, 9, 9]
// Output: 4  → array becomes [2, 3, 6, 9, ...]
// ============================================

// Time: O(n) | Space: O(1)
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    var nextNonDuplicate = 1   // pointer for next unique position

    for i in 1..<nums.count {
        if nums[nextNonDuplicate - 1] != nums[i] {
            nums[nextNonDuplicate] = nums[i]
            nextNonDuplicate += 1
        }
    }
    return nextNonDuplicate
}

// MARK: - Problem 3: Squaring a Sorted Array
// ============================================
// Given sorted array (can have negatives), return
// sorted array of squares
//
// Example:
// Input:  [-4, -1, 0, 3, 10]
// Output: [0, 1, 9, 16, 100]
// ============================================

// Time: O(n) | Space: O(n)
func sortedSquares(_ nums: [Int]) -> [Int] {
    var result = [Int](repeating: 0, count: nums.count)
    var left = 0
    var right = nums.count - 1
    var highestSquareIndex = nums.count - 1

    while left <= right {
        let leftSquare = nums[left] * nums[left]
        let rightSquare = nums[right] * nums[right]

        if leftSquare > rightSquare {
            result[highestSquareIndex] = leftSquare
            left += 1
        } else {
            result[highestSquareIndex] = rightSquare
            right -= 1
        }
        highestSquareIndex -= 1
    }
    return result
}

// MARK: - Problem 4: Three Sum (Triplets Summing to Zero)
// ============================================
// Find all unique triplets that sum to zero
//
// Example:
// Input:  [-3, 0, 1, 2, -1, 1, -2]
// Output: [[-3, 1, 2], [-2, 0, 2], [-2, 1, 1], [-1, 0, 1]]
// ============================================

// Time: O(n²) | Space: O(n) for sorting
func threeSum(_ nums: [Int]) -> [[Int]] {
    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count {
        // Skip duplicate first elements
        if i > 0 && sorted[i] == sorted[i - 1] { continue }

        var left = i + 1
        var right = sorted.count - 1

        while left < right {
            let sum = sorted[i] + sorted[left] + sorted[right]

            if sum == 0 {
                result.append([sorted[i], sorted[left], sorted[right]])
                left += 1
                right -= 1

                // Skip duplicates
                while left < right && sorted[left] == sorted[left - 1] {
                    left += 1
                }
                while left < right && sorted[right] == sorted[right + 1] {
                    right -= 1
                }
            } else if sum < 0 {
                left += 1
            } else {
                right -= 1
            }
        }
    }
    return result
}

// MARK: - Test Cases

// Problem 1
let nums1 = [1, 2, 3, 4, 6]
print(pairWithTargetSum(nums1, target: 6))   // [1, 3]

// Problem 2
var nums2 = [2, 3, 3, 3, 6, 9, 9]
print(removeDuplicates(&nums2))              // 4

// Problem 3
let nums3 = [-4, -1, 0, 3, 10]
print(sortedSquares(nums3))                  // [0, 1, 9, 16, 100]

// Problem 4
let nums4 = [-3, 0, 1, 2, -1, 1, -2]
print(threeSum(nums4))
// [[-3, 1, 2], [-2, 0, 2], [-2, 1, 1], [-1, 0, 1]]

// MARK: - Complexity Analysis
/*
 Two Pointers (Opposite Direction):
   Time  → O(n)  — pointers move toward each other
   Space → O(1)  — no extra memory

 Two Pointers (Same Direction):
   Time  → O(n)  — one pointer tracks position,
                    other scans forward
   Space → O(1)

 Three Sum (Two Pointers + Sort):
   Time  → O(n²) — outer loop O(n) * two pointer scan O(n)
   Space → O(n)  — for sorting

 Key Insight:
 - Works best on SORTED arrays
 - Opposite direction → pair sum, palindrome checks
 - Same direction → remove duplicates, partitioning
 - Reduces O(n²) brute force to O(n) or O(n²) → simpler O(n)
*/
