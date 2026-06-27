// Day 5 — Recursion Practice Problems
// File: RecursionProblems.swift

import Foundation

// MARK: - 1. Reverse a String
// Time: O(n)  |  Space: O(n) stack + O(n) result

func reverse(_ s: String) -> String {
    guard !s.isEmpty else { return s }              // base case
    let idx = s.index(after: s.startIndex)
    return reverse(String(s[idx...])) + s.first!    // recurse on tail, append head at end
}

// Trace: reverse("abc")
//   reverse("bc") + "a"
//     reverse("c") + "b"
//       reverse("") + "c"  → "c"
//     → "cb"
//   → "cba"


// MARK: - 2. Palindrome Check
// Time: O(n)  |  Space: O(n) stack

func isPalindrome(_ s: String) -> Bool {
    let chars = Array(s)
    func check(_ lo: Int, _ hi: Int) -> Bool {
        guard lo < hi else { return true }          // base: pointers met → palindrome
        guard chars[lo] == chars[hi] else { return false }
        return check(lo + 1, hi - 1)               // move both pointers inward
    }
    return check(0, chars.count - 1)
}

// isPalindrome("racecar") → true
// isPalindrome("hello")   → false


// MARK: - 3. Sum of Array
// Time: O(n)  |  Space: O(n) stack

func sum(_ arr: [Int]) -> Int {
    guard !arr.isEmpty else { return 0 }            // base case
    return arr[0] + sum(Array(arr.dropFirst()))     // head + sum(tail)
}

// Cleaner with index (avoids copying subarrays → still O(n) space but less allocation)
func sumIdx(_ arr: [Int], _ i: Int = 0) -> Int {
    guard i < arr.count else { return 0 }
    return arr[i] + sumIdx(arr, i + 1)
}


// MARK: - 4. Flatten Nested Array
// Time: O(n)  |  Space: O(depth) stack
// Swift doesn't have a built-in nested array type,
// so we model nesting with an enum.

indirect enum NestedInt {
    case value(Int)
    case list([NestedInt])
}

func flatten(_ nested: NestedInt) -> [Int] {
    switch nested {
    case .value(let v):
        return [v]                                  // base: single value
    case .list(let items):
        return items.flatMap { flatten($0) }        // recurse into each item
    }
}

// Example: [1, [2, [3, 4]], 5]
let nested: NestedInt = .list([
    .value(1),
    .list([.value(2), .list([.value(3), .value(4)])]),
    .value(5)
])
// flatten(nested) → [1, 2, 3, 4, 5]


// MARK: - 5. Power Set  (all subsets)
// Time: O(2ⁿ)  |  Space: O(2ⁿ) output + O(n) stack
// For every element: include it OR skip it → 2 branches per element

func powerSet(_ nums: [Int]) -> [[Int]] {
    guard !nums.isEmpty else { return [[]] }        // base: one subset — the empty set
    let first = nums[0]
    let rest  = Array(nums.dropFirst())
    let subsetsWithoutFirst = powerSet(rest)
    let subsetsWithFirst    = subsetsWithoutFirst.map { [first] + $0 }
    return subsetsWithoutFirst + subsetsWithFirst
}

// powerSet([1, 2, 3]) →
//   [], [3], [2], [2,3], [1], [1,3], [1,2], [1,2,3]  (8 = 2³ subsets)


// MARK: - 6. Permutations
// Time: O(n!)  |  Space: O(n) stack + O(n!) output
// Pick each element as the first, permute the rest

func permutations(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 1 else { return [nums] }     // base: single element
    var result: [[Int]] = []
    for (i, num) in nums.enumerated() {
        var rest = nums
        rest.remove(at: i)
        for perm in permutations(rest) {
            result.append([num] + perm)             // prepend picked element
        }
    }
    return result
}

// permutations([1, 2, 3]) →
//   [1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]  (6 = 3! perms)


// MARK: - Complexity Summary

/*
 Problem          | Time   | Space  | Key insight
 -----------------|--------|--------|----------------------------------
 Reverse string   | O(n)   | O(n)   | Peel first char, reverse rest
 Palindrome       | O(n)   | O(n)   | Two-pointer via indices
 Sum array        | O(n)   | O(n)   | head + sum(tail)
 Flatten          | O(n)   | O(d)   | d = nesting depth
 Power set        | O(2ⁿ)  | O(2ⁿ)  | include/skip each element
 Permutations     | O(n!)  | O(n!)  | pick each as head, permute rest
*/


// MARK: - Quick Smoke Test

print(reverse("sachin"))                           // "nihcas"
print(isPalindrome("racecar"))                     // true
print(isPalindrome("swift"))                       // false
print(sum([1, 2, 3, 4, 5]))                        // 15
print(flatten(nested))                             // [1, 2, 3, 4, 5]
print(powerSet([1, 2, 3]).count)                   // 8
print(permutations([1, 2, 3]).count)               // 6
