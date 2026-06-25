// Day 4 — Recursion & Complexity Analysis
// File: RecursionComplexity.swift

import Foundation

// MARK: - 1. What is Recursion?
// A function that calls itself with a smaller subproblem,
// until it hits a base case that stops the chain.

// Rule: Every recursive function needs
//   (a) a base case  → stops recursion
//   (b) recursive case → moves toward the base case

// MARK: - 2. Factorial  —  O(n) time | O(n) space

func factorial(_ n: Int) -> Int {
    guard n > 1 else { return 1 }   // base case: 0! = 1! = 1
    return n * factorial(n - 1)     // recursive case
}
// Call stack for factorial(4):
//   factorial(4) → 4 * factorial(3)
//     factorial(3) → 3 * factorial(2)
//       factorial(2) → 2 * factorial(1)
//         factorial(1) → 1          ← base case, stack unwinds

// MARK: - 3. Fibonacci  —  O(2ⁿ) time | O(n) space (naive)

func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }   // base: fib(0)=0, fib(1)=1
    return fib(n - 1) + fib(n - 2) // two recursive calls → exponential
}
// Each call spawns 2 children → ~2ⁿ total calls.
// Stack depth is still only n (the longest path root→leaf).

// MARK: - 4. Memoised Fibonacci  —  O(n) time | O(n) space

func fibMemo(_ n: Int, _ cache: inout [Int: Int]) -> Int {
    if let cached = cache[n] { return cached }
    guard n > 1 else { return n }
    let result = fibMemo(n - 1, &cache) + fibMemo(n - 2, &cache)
    cache[n] = result
    return result
}
// Each unique n is computed once → O(n) calls, O(n) cache.

// MARK: - 5. Binary Search (recursive)  —  O(log n) time | O(log n) space

func binarySearch(_ arr: [Int], target: Int, lo: Int, hi: Int) -> Int? {
    guard lo <= hi else { return nil }                  // base: not found
    let mid = lo + (hi - lo) / 2
    if arr[mid] == target { return mid }                // base: found
    if arr[mid] > target {
        return binarySearch(arr, target: target, lo: lo, hi: mid - 1)
    } else {
        return binarySearch(arr, target: target, lo: mid + 1, hi: hi)
    }
}
// Halves the search space each call → O(log n) depth.

// MARK: - 6. Sum of Digits  —  O(log₁₀ n) time | O(log₁₀ n) space

func digitSum(_ n: Int) -> Int {
    guard n >= 10 else { return n }
    return (n % 10) + digitSum(n / 10)
}

// MARK: - 7. Power  —  O(log n) via divide-and-conquer

func power(_ base: Double, _ exp: Int) -> Double {
    guard exp > 0 else { return 1 }
    if exp % 2 == 0 {
        let half = power(base, exp / 2)
        return half * half          // reuse: exp=8 → exp=4 → exp=2 → exp=1
    }
    return base * power(base, exp - 1)
}

// MARK: - 8. Complexity Cheat Sheet

/*
 Pattern                           | Time      | Space (stack)
 ----------------------------------|-----------|---------------
 Single linear recursion           | O(n)      | O(n)
 Tail recursion (compiled away)    | O(n)      | O(1)*
 Two branches, no overlap (fib)    | O(2ⁿ)     | O(n)
 Two branches + memo (fib)         | O(n)      | O(n)
 Halving each call (binary search) | O(log n)  | O(log n)
 Halving + two branches (merge)    | O(n log n)| O(n)
 Divide-and-conquer power          | O(log n)  | O(log n)

 * Swift does not guarantee TCO — treat tail recursion as O(n) stack.

 The Master Theorem shortcut:
   T(n) = a · T(n/b) + O(nᵈ)
   a = number of recursive calls
   b = factor by which input shrinks
   d = work done outside the recursive call

   If a < bᵈ  →  O(nᵈ)
   If a = bᵈ  →  O(nᵈ log n)
   If a > bᵈ  →  O(n^log_b(a))

 Example — merge sort: a=2, b=2, d=1
   2 = 2¹  →  O(n log n) ✓
*/

// MARK: - 9. Playground

var cache: [Int: Int] = [:]
print(factorial(5))                               // 120
print(fib(6))                                     // 8
print(fibMemo(40, &cache))                        // 102334155
print(binarySearch([1,3,5,7,9], target: 7,
                   lo: 0, hi: 4) ?? -1)           // 3
print(digitSum(9453))                             // 21
print(power(2, 10))                               // 1024.0
