import Foundation

// ============================================
// Prefix Sum Technique
// ============================================
// Prefix sum is a precomputation technique where we
// build an array where each element is the sum of
// all elements before it (including itself).
//
// Once built, any range sum query is answered in O(1)
// instead of O(n) every time.
//
// Time to build: O(n)
// Time to query: O(1)
// Space: O(n)
// ============================================

// MARK: - Concept: Building a Prefix Sum Array

func buildPrefixSum(_ nums: [Int]) -> [Int] {
    var prefix = [Int](repeating: 0, count: nums.count)
    prefix[0] = nums[0]

    for i in 1..<nums.count {
        prefix[i] = prefix[i - 1] + nums[i]
    }
    return prefix
}

// Range sum query using prefix sum
// Sum of elements from index l to r (inclusive)
// Time: O(1) after O(n) build
func rangeSum(_ prefix: [Int], l: Int, r: Int) -> Int {
    if l == 0 { return prefix[r] }
    return prefix[r] - prefix[l - 1]
}

// MARK: - Problem 1: Range Sum Query
// ============================================
// Given array, answer multiple range sum queries
//
// Example:
// Input:  nums = [1, 2, 3, 4, 5]
// Query:  sum(1, 3) → 2 + 3 + 4 = 9
// Query:  sum(0, 4) → 1 + 2 + 3 + 4 + 5 = 15
// ============================================

class RangeSumQuery {
    private var prefix: [Int]

    // Time: O(n) to build
    init(_ nums: [Int]) {
        prefix = [Int](repeating: 0, count: nums.count)
        prefix[0] = nums[0]
        for i in 1..<nums.count {
            prefix[i] = prefix[i - 1] + nums[i]
        }
    }

    // Time: O(1) per query
    func sumRange(_ left: Int, _ right: Int) -> Int {
        if left == 0 { return prefix[right] }
        return prefix[right] - prefix[left - 1]
    }
}

// MARK: - Problem 2: Subarray Sum Equals K
// ============================================
// Count total number of subarrays that sum to k
//
// Example:
// Input:  [1, 1, 1], k = 2
// Output: 2  → [1,1] at index 0-1 and 1-2
// ============================================

// Time: O(n) | Space: O(n)
func subarraySum(_ nums: [Int], k: Int) -> Int {
    var count = 0
    var currentSum = 0
    var prefixSums = [Int: Int]()  // sum: frequency
    prefixSums[0] = 1              // empty subarray base case

    for num in nums {
        currentSum += num

        // Check if any prefix sum exists that makes
        // currentSum - k the difference
        if let freq = prefixSums[currentSum - k] {
            count += freq
        }

        prefixSums[currentSum, default: 0] += 1
    }
    return count
}

// MARK: - Problem 3: Find Pivot Index
// ============================================
// Find index where left sum equals right sum
//
// Example:
// Input:  [1, 7, 3, 6, 5, 6]
// Output: 3  → left sum = 1+7+3 = 11, right sum = 5+6 = 11
// ============================================

// Time: O(n) | Space: O(1)
func pivotIndex(_ nums: [Int]) -> Int {
    let totalSum = nums.reduce(0, +)
    var leftSum = 0

    for (i, num) in nums.enumerated() {
        // Right sum = total - leftSum - current element
        let rightSum = totalSum - leftSum - num

        if leftSum == rightSum { return i }

        leftSum += num
    }
    return -1
}

// MARK: - Problem 4: Product of Array Except Self
// ============================================
// Return array where each element is product of
// all other elements (no division allowed)
//
// Example:
// Input:  [1, 2, 3, 4]
// Output: [24, 12, 8, 6]
// ============================================

// Time: O(n) | Space: O(n)
func productExceptSelf(_ nums: [Int]) -> [Int] {
    let n = nums.count
    var result = [Int](repeating: 1, count: n)

    // Left pass — result[i] = product of all elements left of i
    var leftProduct = 1
    for i in 0..<n {
        result[i] = leftProduct
        leftProduct *= nums[i]
    }

    // Right pass — multiply by product of all elements right of i
    var rightProduct = 1
    for i in stride(from: n - 1, through: 0, by: -1) {
        result[i] *= rightProduct
        rightProduct *= nums[i]
    }

    return result
}

// MARK: - Problem 5: Contiguous Array (Equal 0s and 1s)
// ============================================
// Find max length subarray with equal 0s and 1s
//
// Example:
// Input:  [0, 1, 0, 0, 1, 1, 0]
// Output: 6  → subarray [1, 0, 0, 1, 1, 0]
// ============================================

// Time: O(n) | Space: O(n)
func findMaxLength(_ nums: [Int]) -> Int {
    var maxLength = 0
    var count = 0
    var prefixMap = [Int: Int]()  // count: first index seen
    prefixMap[0] = -1             // base case

    for (i, num) in nums.enumerated() {
        // Treat 0 as -1 so equal 0s and 1s cancel out to 0
        count += num == 1 ? 1 : -1

        if let firstIndex = prefixMap[count] {
            maxLength = max(maxLength, i - firstIndex)
        } else {
            prefixMap[count] = i
        }
    }
    return maxLength
}

// MARK: - Test Cases

// Concept
let nums0 = [1, 2, 3, 4, 5]
let prefix = buildPrefixSum(nums0)
print(rangeSum(prefix, l: 1, r: 3))    // 9 → 2+3+4
print(rangeSum(prefix, l: 0, r: 4))    // 15 → all

// Problem 1
let query = RangeSumQuery([1, 2, 3, 4, 5])
print(query.sumRange(1, 3))             // 9
print(query.sumRange(0, 4))             // 15

// Problem 2
print(subarraySum([1, 1, 1], k: 2))    // 2

// Problem 3
print(pivotIndex([1, 7, 3, 6, 5, 6]))  // 3

// Problem 4
print(productExceptSelf([1, 2, 3, 4])) // [24, 12, 8, 6]

// Problem 5
print(findMaxLength([0, 1, 0, 0, 1, 1, 0]))  // 6

// MARK: - Complexity Analysis
/*
 Prefix Sum Build:
   Time  → O(n)  — single pass to build prefix array
   Space → O(n)  — extra array of same size

 Range Sum Query:
   Time  → O(1)  — direct subtraction after build
   Space → O(1)  — no extra memory per query

 Subarray Sum Equals K:
   Time  → O(n)  — single pass with hash map
   Space → O(n)  — hash map stores prefix sums

 Key Insight:
 prefix[r] - prefix[l-1] = sum of elements from l to r
 This is the core formula behind all prefix sum problems.

 When to use Prefix Sum:
 - Multiple range sum queries on same array 
 - Count subarrays with sum equal to k
 - Problems involving cumulative totals
 - When you need O(1) range queries after O(n) setup
*/
