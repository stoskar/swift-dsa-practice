import Foundation

// ============================================
// Two Sum Pattern Using Hashing
// ============================================
// Two Sum is the foundation of many hashing problems.
// Instead of checking every pair O(n²),
// we store seen elements in a hash map for O(1) lookup.
//
// Core Idea:
// For each element x, check if (target - x) exists
// in the hash map. If yes → found the pair.
// ============================================

// MARK: - Problem 1: Two Sum (Classic)
// ============================================
// Return indices of two numbers that add to target
//
// Example:
// Input:  [2, 7, 11, 15], target = 9
// Output: [0, 1]  → 2 + 7 = 9
//
// Time: O(n) | Space: O(n)
// ============================================

func twoSum(_ nums: [Int], target: Int) -> [Int] {
    var seen = [Int: Int]()     // value: index

    for (i, num) in nums.enumerated() {
        let complement = target - num

        if let j = seen[complement] {
            return [j, i]
        }
        seen[num] = i
    }
    return []
}

// MARK: - Problem 2: Two Sum II (Sorted Array)
// ============================================
// Array is sorted — find pair that sums to target
// Return 1-indexed positions
//
// Example:
// Input:  [2, 7, 11, 15], target = 9
// Output: [1, 2]
//
// Approach 1: Hash Map → Time: O(n) | Space: O(n)
// Approach 2: Two Pointers → Time: O(n) | Space: O(1)
// ============================================

// Hash Map approach
func twoSumIIHashMap(_ nums: [Int], target: Int) -> [Int] {
    var seen = [Int: Int]()

    for (i, num) in nums.enumerated() {
        let complement = target - num

        if let j = seen[complement] {
            return [j + 1, i + 1]   // 1-indexed
        }
        seen[num] = i
    }
    return []
}

// Two Pointers approach (optimal for sorted)
func twoSumIITwoPointers(_ nums: [Int], target: Int) -> [Int] {
    var left = 0
    var right = nums.count - 1

    while left < right {
        let sum = nums[left] + nums[right]

        if sum == target {
            return [left + 1, right + 1]
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    return []
}

// MARK: - Problem 3: Two Sum — Count Pairs
// ============================================
// Count number of pairs that sum to target
//
// Example:
// Input:  [1, 5, 3, 3, 3], target = 6
// Output: 4  → (1,5), (3,3), (3,3), (3,3)
//
// Time: O(n) | Space: O(n)
// ============================================

func countPairsWithSum(_ nums: [Int], target: Int) -> Int {
    var freq = [Int: Int]()
    var count = 0

    for num in nums {
        let complement = target - num

        // Add existing complement pairs to count
        count += freq[complement, default: 0]

        freq[num, default: 0] += 1
    }
    return count
}

// MARK: - Problem 4: Four Sum Count
// ============================================
// Count tuples (i,j,k,l) where
// nums1[i] + nums2[j] + nums3[k] + nums4[l] == 0
//
// Example:
// Input:  nums1=[1,2], nums2=[-2,-1], nums3=[-1,2], nums4=[0,2]
// Output: 2
//
// Time: O(n²) | Space: O(n²)
// ============================================

func fourSumCount(_ nums1: [Int], _ nums2: [Int],
                  _ nums3: [Int], _ nums4: [Int]) -> Int {
    var pairSums = [Int: Int]()

    // Store all sums of pairs from nums1 + nums2
    for a in nums1 {
        for b in nums2 {
            pairSums[a + b, default: 0] += 1
        }
    }

    var count = 0

    // Check if complement exists for each pair in nums3 + nums4
    for c in nums3 {
        for d in nums4 {
            let complement = -(c + d)
            count += pairSums[complement, default: 0]
        }
    }
    return count
}

// MARK: - Problem 5: Subarray Sum Equals K
// ============================================
// Count subarrays that sum to k
//
// Example:
// Input:  [1, 1, 1], k = 2
// Output: 2  → [1,1] at index 0-1 and 1-2
//
// Key Insight:
// If prefixSum[j] - prefixSum[i] = k
// then subarray from i+1 to j sums to k
//
// Time: O(n) | Space: O(n)
// ============================================

func subarraySumEqualsK(_ nums: [Int], k: Int) -> Int {
    var prefixSums = [Int: Int]()
    prefixSums[0] = 1       // empty subarray base case
    var currentSum = 0
    var count = 0

    for num in nums {
        currentSum += num

        // Check if (currentSum - k) was seen before
        if let freq = prefixSums[currentSum - k] {
            count += freq
        }

        prefixSums[currentSum, default: 0] += 1
    }
    return count
}

// MARK: - Problem 6: Continuous Subarray Sum
// ============================================
// Return true if array has subarray of length
// at least 2 whose sum is multiple of k
//
// Example:
// Input:  [23, 2, 4, 6, 7], k = 6
// Output: true  → [2, 4] sums to 6
//
// Key Insight:
// If prefix[i] % k == prefix[j] % k
// then subarray between i and j is multiple of k
//
// Time: O(n) | Space: O(n)
// ============================================

func checkSubarraySum(_ nums: [Int], k: Int) -> Bool {
    var remainders = [Int: Int]()
    remainders[0] = -1      // base case — empty prefix
    var currentSum = 0

    for (i, num) in nums.enumerated() {
        currentSum += num
        let remainder = currentSum % k

        if let prevIndex = remainders[remainder] {
            // Subarray length must be at least 2
            if i - prevIndex >= 2 { return true }
        } else {
            remainders[remainder] = i
        }
    }
    return false
}

// MARK: - Problem 7: Two Sum — All Pairs
// ============================================
// Return all unique pairs that sum to target
//
// Example:
// Input:  [1, 5, 3, 2, 4], target = 6
// Output: [[1,5], [2,4]]
//
// Time: O(n) | Space: O(n)
// ============================================

func allPairsWithSum(_ nums: [Int], target: Int) -> [[Int]] {
    var seen = Set<Int>()
    var used = Set<Int>()
    var result = [[Int]]()

    for num in nums {
        let complement = target - num

        if seen.contains(complement) && !used.contains(num) {
            result.append([min(num, complement), max(num, complement)])
            used.insert(num)
            used.insert(complement)
        }
        seen.insert(num)
    }
    return result
}

// MARK: - Test Cases

// Problem 1
print(twoSum([2, 7, 11, 15], target: 9))        // [0, 1]
print(twoSum([3, 2, 4], target: 6))              // [1, 2]
print(twoSum([3, 3], target: 6))                 // [0, 1]

// Problem 2
print(twoSumIIHashMap([2, 7, 11, 15], target: 9))       // [1, 2]
print(twoSumIITwoPointers([2, 7, 11, 15], target: 9))   // [1, 2]

// Problem 3
print(countPairsWithSum([1, 5, 3, 3, 3], target: 6))    // 4

// Problem 4
print(fourSumCount([1,2], [-2,-1], [-1,2], [0,2]))      // 2

// Problem 5
print(subarraySumEqualsK([1, 1, 1], k: 2))      // 2
print(subarraySumEqualsK([1, 2, 3], k: 3))      // 2

// Problem 6
print(checkSubarraySum([23, 2, 4, 6, 7], k: 6)) // true
print(checkSubarraySum([23, 2, 6, 4, 7], k: 13))// false

// Problem 7
print(allPairsWithSum([1, 5, 3, 2, 4], target: 6))  // [[1,5], [2,4]]
print(allPairsWithSum([1, 1, 1], target: 2))         // [[1,1]]

// MARK: - Complexity Summary
/*
 Problem                    Time      Space    Key Insight
 ──────────────────────────────────────────────────────────────
 Two Sum Classic            O(n)      O(n)     Store complement
 Two Sum II (HashMap)       O(n)      O(n)     Store complement
 Two Sum II (Two Pointers)  O(n)      O(1)     Sorted → pointers
 Count Pairs                O(n)      O(n)     Count complements
 Four Sum Count             O(n²)     O(n²)    Split into 2 pairs
 Subarray Sum = K           O(n)      O(n)     Prefix sum + hash
 Continuous Subarray Sum    O(n)      O(n)     Remainder pattern
 All Pairs                  O(n)      O(n)     Track used pairs

 Core Two Sum Pattern:
 ─────────────────────
 var seen = [Int: Int]()
 for (i, num) in nums.enumerated() {
     let complement = target - num
     if let j = seen[complement] {
         return [j, i]           ← found pair
     }
     seen[num] = i               ← store for later
 }

 Key Insight for Subarray Problems:
 ────────────────────────────────────
 prefix[j] - prefix[i] = k
 → prefix[i] = prefix[j] - k
 → store prefix sums in hash map
 → check if (currentSum - k) was seen before
*/
