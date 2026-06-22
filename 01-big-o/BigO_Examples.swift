import Foundation

// ============================================
// Big-O Notation — Practice Examples in Swift
// ============================================

// MARK: - O(1) Constant Time
func getFirstElement(_ arr: [Int]) -> Int? {
    return arr.first  // always one operation regardless of size
}

// MARK: - O(n) Linear Time
func linearSearch(_ arr: [Int], target: Int) -> Int? {
    for (index, value) in arr.enumerated() {
        if value == target { return index }
    }
    return nil
}

// MARK: - O(n²) Quadratic Time
func printAllPairs(_ arr: [Int]) {
    for i in arr {
        for j in arr {
            print("(\(i), \(j))")
        }
    }
}

// MARK: - O(log n) Logarithmic Time
func binarySearch(_ arr: [Int], target: Int) -> Int? {
    var left = 0
    var right = arr.count - 1

    while left <= right {
        let mid = (left + right) / 2
        if arr[mid] == target { return mid }
        else if arr[mid] < target { left = mid + 1 }
        else { right = mid - 1 }
    }
    return nil
}

// MARK: - O(n log n) Log Linear Time
func mergeSort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    let mid = arr.count / 2
    let left = mergeSort(Array(arr[..<mid]))
    let right = mergeSort(Array(arr[mid...]))
    return merge(left, right)
}

private func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result = [Int]()
    var i = 0, j = 0
    while i < left.count && j < right.count {
        if left[i] < right[j] { result.append(left[i]); i += 1 }
        else { result.append(right[j]); j += 1 }
    }
    return result + Array(left[i...]) + Array(right[j...])
}

// MARK: - O(2ⁿ) Exponential Time
func fibonacci(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

// MARK: - Space Complexity Examples

// O(1) space
func sumArray(_ arr: [Int]) -> Int {
    var total = 0
    for n in arr { total += n }
    return total
}

// O(n) space
func doubleArray(_ arr: [Int]) -> [Int] {
    return arr.map { $0 * 2 }
}
