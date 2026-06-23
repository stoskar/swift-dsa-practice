import Foundation

// ============================================
// Space Complexity — Practice Examples in Swift
// ============================================

// MARK: - O(1) Constant Space
// No extra memory used — only fixed variables

func findMax(_ arr: [Int]) -> Int? {
    guard !arr.isEmpty else { return nil }
    var max = arr[0]          // single variable — O(1)
    for num in arr {
        if num > max { max = num }
    }
    return max
}

func reverseInPlace(_ arr: inout [Int]) {
    var left = 0
    var right = arr.count - 1  // two pointers — still O(1)
    while left < right {
        arr.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - O(n) Linear Space
// Extra memory grows with input size

func reverseArray(_ arr: [Int]) -> [Int] {
    var result = [Int]()       // new array of size n — O(n)
    for num in arr.reversed() {
        result.append(num)
    }
    return result
}

func prefixSum(_ arr: [Int]) -> [Int] {
    var sums = [Int](repeating: 0, count: arr.count)  // O(n)
    sums[0] = arr[0]
    for i in 1..<arr.count {
        sums[i] = sums[i - 1] + arr[i]
    }
    return sums
}

func copyDictionary(_ dict: [String: Int]) -> [String: Int] {
    var copy = [String: Int]()  // new dictionary of size n — O(n)
    for (key, value) in dict {
        copy[key] = value
    }
    return copy
}

// MARK: - O(n) Space — Recursive Call Stack
// Each recursive call takes up stack space

func factorialRecursive(_ n: Int) -> Int {
    // n calls on call stack simultaneously — O(n) space
    if n <= 1 { return 1 }
    return n * factorialRecursive(n - 1)
}

func sumRecursive(_ arr: [Int], index: Int = 0) -> Int {
    // arr.count calls on stack — O(n) space
    if index == arr.count { return 0 }
    return arr[index] + sumRecursive(arr, index: index + 1)
}

// MARK: - O(n²) Quadratic Space
// 2D array or matrix

func create2DMatrix(_ n: Int) -> [[Int]] {
    // n * n elements — O(n²) space
    return [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
}

func multiplicationTable(_ n: Int) -> [[Int]] {
    var table = [[Int]]()       // O(n²)
    for i in 1...n {
        var row = [Int]()
        for j in 1...n {
            row.append(i * j)
        }
        table.append(row)
    }
    return table
}

// MARK: - O(log n) Space
// Recursive binary search — log n calls on stack

func binarySearchRecursive(
    _ arr: [Int],
    target: Int,
    left: Int,
    right: Int
) -> Int? {
    // log n recursive calls on stack — O(log n) space
    guard left <= right else { return nil }
    let mid = (left + right) / 2
    if arr[mid] == target { return mid }
    else if arr[mid] < target {
        return binarySearchRecursive(arr, target: target, left: mid + 1, right: right)
    } else {
        return binarySearchRecursive(arr, target: target, left: left, right: mid - 1)
    }
}

// MARK: - Summary
/*
 Space Complexity Quick Reference:
 
 O(1)      → fixed variables, in-place operations
 O(log n)  → recursive binary search call stack
 O(n)      → new array/dict of input size, linear recursion stack
 O(n²)     → 2D matrix, nested data structures
 
 Key insight:
 Recursive functions use O(depth) space for the call stack
 even if no extra arrays are created.
*/
