import Foundation

// ============================================
// Longest Consecutive Sequence
// ============================================
// Given an unsorted array of integers, find the
// length of the longest consecutive sequence.
//
// Example 1:
// Input:  [100, 4, 200, 1, 3, 2]
// Output: 4  → [1, 2, 3, 4]
//
// Example 2:
// Input:  [0, 3, 7, 2, 5, 8, 4, 6, 0, 1]
// Output: 9  → [0,1,2,3,4,5,6,7,8]
//
// Constraints:
// - Must run in O(n) time
// ============================================

// MARK: - Approach 1: Brute Force
// For each number check if sequence exists
// Time: O(n³) | Space: O(1)

func longestConsecutiveBrute(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var longest = 0

    for num in nums {
        var currentNum = num
        var currentStreak = 1

        // Keep checking next number exists
        while nums.contains(currentNum + 1) {
            currentNum += 1
            currentStreak += 1
        }
        longest = max(longest, currentStreak)
    }
    return longest
}

// MARK: - Approach 2: Sort First
// Sort then count consecutive elements
// Time: O(n log n) | Space: O(1)

func longestConsecutiveSort(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    let sorted = nums.sorted()
    var longest = 1
    var currentStreak = 1

    for i in 1..<sorted.count {
        if sorted[i] == sorted[i - 1] {
            continue    // skip duplicates
        } else if sorted[i] == sorted[i - 1] + 1 {
            currentStreak += 1
            longest = max(longest, currentStreak)
        } else {
            currentStreak = 1   // reset streak
        }
    }
    return longest
}

// MARK: - Approach 3: HashSet (Optimal)
// Only start counting from sequence start numbers
// Time: O(n) | Space: O(n)
//
// Key Insight:
// A number is the START of a sequence if
// (num - 1) does NOT exist in the set.
// Only count streaks from sequence starts
// to avoid redundant work.

func longestConsecutive(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    let numSet = Set(nums)
    var longest = 0

    for num in numSet {
        // Only start counting if num is sequence start
        if !numSet.contains(num - 1) {
            var currentNum = num
            var currentStreak = 1

            // Count consecutive numbers forward
            while numSet.contains(currentNum + 1) {
                currentNum += 1
                currentStreak += 1
            }

            longest = max(longest, currentStreak)
        }
    }
    return longest
}

// MARK: - Problem 2: Longest Consecutive Sequence II
// ============================================
// Return the actual sequence not just its length
//
// Example:
// Input:  [100, 4, 200, 1, 3, 2]
// Output: [1, 2, 3, 4]
//
// Time: O(n) | Space: O(n)
// ============================================

func longestConsecutiveSequence(_ nums: [Int]) -> [Int] {
    guard !nums.isEmpty else { return [] }

    let numSet = Set(nums)
    var longestStart = 0
    var longestLength = 0

    for num in numSet {
        if !numSet.contains(num - 1) {
            var currentNum = num
            var currentLength = 1

            while numSet.contains(currentNum + 1) {
                currentNum += 1
                currentLength += 1
            }

            if currentLength > longestLength {
                longestLength = currentLength
                longestStart = num
            }
        }
    }

    // Build the actual sequence
    return (longestStart..<longestStart + longestLength).map { $0 }
}

// MARK: - Problem 3: Consecutive Numbers Sum
// ============================================
// Given n, find how many ways to write n
// as sum of consecutive positive integers
//
// Example:
// Input:  n = 5
// Output: 3  → 5, 4+1, 2+3
//
// Input:  n = 15
// Output: 4  → 15, 14+1, 4+5+6, 1+2+3+4+5
//
// Time: O(√n) | Space: O(1)
// ============================================

func consecutiveNumbersSum(_ n: Int) -> Int {
    var count = 0
    var k = 1

    // Sum of k consecutive from x: k*x + k*(k-1)/2 = n
    // x = (n - k*(k-1)/2) / k must be positive integer
    while k * (k + 1) / 2 <= n {
        let remainder = n - k * (k - 1) / 2
        if remainder % k == 0 {
            count += 1
        }
        k += 1
    }
    return count
}

// MARK: - Problem 4: Missing Ranges
// ============================================
// Given sorted array and range [lower, upper],
// return missing ranges as formatted strings
//
// Example:
// Input:  [0, 1, 3, 50, 75], lower = 0, upper = 99
// Output: ["2", "4->49", "51->74", "76->99"]
//
// Time: O(n) | Space: O(n)
// ============================================

func findMissingRanges(_ nums: [Int], lower: Int, upper: Int) -> [String] {
    var result = [String]()
    var prev = lower - 1

    for i in 0...nums.count {
        let curr = i < nums.count ? nums[i] : upper + 1

        if curr - prev >= 2 {
            // Gap found
            let start = prev + 1
            let end = curr - 1

            if start == end {
                result.append("\(start)")
            } else {
                result.append("\(start)->\(end)")
            }
        }
        prev = curr
    }
    return result
}

// MARK: - Problem 5: Longest Arithmetic Subsequence
// ============================================
// Find length of longest arithmetic subsequence
// (elements with equal difference between them)
//
// Example:
// Input:  [3, 6, 9, 12]
// Output: 4  → difference = 3
//
// Input:  [9, 4, 7, 2, 10]
// Output: 3  → [4, 7, 10] difference = 3
//
// Time: O(n²) | Space: O(n²)
// ============================================

func longestArithSeqLength(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return 1 }

    // dp[i][diff] = length of arithmetic subseq ending at i with diff
    var dp = [[Int: Int]](repeating: [:], count: nums.count)
    var longest = 2

    for i in 1..<nums.count {
        for j in 0..<i {
            let diff = nums[i] - nums[j]
            let prevLength = dp[j][diff] ?? 1
            dp[i][diff] = prevLength + 1
            longest = max(longest, dp[i][diff]!)
        }
    }
    return longest
}

// MARK: - Problem 6: Find K-th Missing Positive
// ============================================
// Find k-th missing positive integer
//
// Example:
// Input:  [2, 3, 4, 7, 11], k = 5
// Output: 9
// → missing: 1, 5, 6, 8, 9 → 5th = 9
//
// Time: O(n) | Space: O(n)
// ============================================

func findKthPositive(_ arr: [Int], k: Int) -> Int {
    let numSet = Set(arr)
    var missing = 0
    var current = 0

    while missing < k {
        current += 1
        if !numSet.contains(current) {
            missing += 1
        }
    }
    return current
}

// MARK: - Test Cases

// Approach 1
print(longestConsecutiveBrute([100, 4, 200, 1, 3, 2]))  // 4

// Approach 2
print(longestConsecutiveSort([0,3,7,2,5,8,4,6,0,1]))    // 9

// Approach 3 (Optimal)
print(longestConsecutive([100, 4, 200, 1, 3, 2]))        // 4
print(longestConsecutive([0,3,7,2,5,8,4,6,0,1]))         // 9
print(longestConsecutive([]))                             // 0
print(longestConsecutive([1]))                            // 1

// Problem 2
print(longestConsecutiveSequence([100, 4, 200, 1, 3, 2]))   // [1,2,3,4]
print(longestConsecutiveSequence([0,3,7,2,5,8,4,6,0,1]))    // [0..8]

// Problem 3
print(consecutiveNumbersSum(5))     // 3
print(consecutiveNumbersSum(9))     // 3
print(consecutiveNumbersSum(15))    // 4

// Problem 4
print(findMissingRanges([0,1,3,50,75], lower: 0, upper: 99))
// ["2", "4->49", "51->74", "76->99"]

// Problem 5
print(longestArithSeqLength([3, 6, 9, 12]))     // 4
print(longestArithSeqLength([9, 4, 7, 2, 10]))  // 3

// Problem 6
print(findKthPositive([2,3,4,7,11], k: 5))      // 9
print(findKthPositive([1,2,3,4], k: 2))         // 6

// MARK: - Complexity Summary
/*
 Approach                       Time        Space   Key Insight
 ──────────────────────────────────────────────────────────────
 Brute Force                    O(n³)       O(1)    contains() each step
 Sort First                     O(n log n)  O(1)    sort then scan
 HashSet (Optimal)              O(n)        O(n)    only start from seq start
 Return Actual Sequence         O(n)        O(n)    track start + length
 Consecutive Numbers Sum        O(√n)       O(1)    math formula
 Missing Ranges                 O(n)        O(n)    gap detection
 Longest Arithmetic Subseq      O(n²)       O(n²)   DP + hash map
 Kth Missing Positive           O(n)        O(n)    set lookup

 Core HashSet Pattern:
 ──────────────────────
 let numSet = Set(nums)

 for num in numSet {
     // Only process sequence START numbers
     if !numSet.contains(num - 1) {
         var streak = 1
         var current = num
         while numSet.contains(current + 1) {
             current += 1
             streak += 1
         }
         longest = max(longest, streak)
     }
 }

 Why O(n) and not O(n²)?
 Each number is only visited ONCE as part
 of exactly one sequence. The "start check"
 ensures we never recount the same sequence.
 Total work across ALL sequences = O(n).
*/
