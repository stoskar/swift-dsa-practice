import Foundation

// ============================================
// Problem: Move Zeroes
// ============================================
// Given an array, move all 0s to the end while
// maintaining relative order of non-zero elements.
// Must be done IN-PLACE.
//
// Example:
// Input:  [0, 1, 0, 3, 12]
// Output: [1, 3, 12, 0, 0]
//
// Constraints:
// - Must do in-place (no extra array)
// - Maintain relative order of non-zero elements
// ============================================

// MARK: - Approach 1: Brute Force
// Collect non-zero elements, fill rest with zeros
// Time: O(n) | Space: O(n)

func moveZeroesBrute(_ nums: inout [Int]) {
    var nonZero = nums.filter { $0 != 0 }  // O(n) extra space
    let zeroCount = nums.count - nonZero.count

    nonZero.append(contentsOf: [Int](repeating: 0, count: zeroCount))
    nums = nonZero
}

// MARK: - Approach 2: Two Pointers (Optimal)
// One pointer tracks position for next non-zero element
// Time: O(n) | Space: O(1)

func moveZeroesOptimal(_ nums: inout [Int]) {
    var insertPos = 0   // position for next non-zero element

    // Move all non-zero elements to front
    for num in nums {
        if num != 0 {
            nums[insertPos] = num
            insertPos += 1
        }
    }

    // Fill remaining positions with zeros
    while insertPos < nums.count {
        nums[insertPos] = 0
        insertPos += 1
    }
}

// MARK: - Approach 3: Two Pointers with Swap
// Swap non-zero elements with zero positions
// Time: O(n) | Space: O(1)

func moveZeroesSwap(_ nums: inout [Int]) {
    var left = 0    // points to next zero position

    for right in 0..<nums.count {
        if nums[right] != 0 {
            nums.swapAt(left, right)
            left += 1
        }
    }
}

// MARK: - Test Cases

var nums1 = [0, 1, 0, 3, 12]
moveZeroesOptimal(&nums1)
print(nums1)    // [1, 3, 12, 0, 0]

var nums2 = [0, 0, 1]
moveZeroesSwap(&nums2)
print(nums2)    // [1, 0, 0]

var nums3 = [0]
moveZeroesOptimal(&nums3)
print(nums3)    // [0]

var nums4 = [1, 2, 3]
moveZeroesSwap(&nums4)
print(nums4)    // [1, 2, 3] — no change

// MARK: - Complexity Analysis
/*
 Brute Force:
   Time  → O(n)  — filter + fill
   Space → O(n)  — extra array for non-zero elements

 Two Pointers (Optimal):
   Time  → O(n)  — single pass
   Space → O(1)  — only one pointer variable

 Two Pointers (Swap):
   Time  → O(n)  — single pass
   Space → O(1)  — only one pointer variable

 Key Insight:
 Use a slow pointer to track where next non-zero
 element should go. Fast pointer scans the array.
 When fast pointer finds non-zero → place/swap it
 at slow pointer position → advance slow pointer.
*/
