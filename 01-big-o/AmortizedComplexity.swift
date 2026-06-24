import Foundation

// ============================================
// Amortized Complexity — Practice Examples in Swift
// ============================================

// MARK: - What is Amortized Complexity?
// Amortized complexity is the AVERAGE cost per operation
// over a sequence of operations — even if some are expensive.
// Think of it as "spreading" the cost of rare expensive
// operations across many cheap ones.

// MARK: - Example 1: Dynamic Array (like Swift Array)
// append() is usually O(1) but occasionally O(n) when resizing
// Amortized cost = O(1)

struct DynamicArray {
    private var storage: [Int] = []
    private var count = 0
    private var capacity = 1

    mutating func append(_ value: Int) {
        if count == capacity {
            // Expensive resize — O(n) but happens rarely
            resize()
        }
        storage.append(value)  // O(1) most of the time
        count += 1
    }

    private mutating func resize() {
        capacity *= 2   // double the capacity
        // copying all elements = O(n) but amortized O(1)
        print("Resizing to capacity: \(capacity)")
    }

    // Amortized Analysis:
    // n appends → resize happens at 1, 2, 4, 8... log(n) times
    // Total cost = n + (1 + 2 + 4 + ... + n) = O(n)
    // Per operation = O(n) / n = O(1) amortized
}

// MARK: - Example 2: Stack with Amortized O(1) Push
// Standard stack push is always O(1)
// But if we track min/max — still O(1) amortized

struct MinStack {
    private var stack = [Int]()
    private var minStack = [Int]()  // tracks minimums

    // O(1) amortized
    mutating func push(_ value: Int) {
        stack.append(value)
        if minStack.isEmpty || value <= minStack.last! {
            minStack.append(value)
        }
    }

    // O(1)
    mutating func pop() -> Int? {
        guard let top = stack.popLast() else { return nil }
        if top == minStack.last {
            minStack.removeLast()
        }
        return top
    }

    // O(1)
    func getMin() -> Int? {
        return minStack.last
    }
}

// MARK: - Example 3: Increment Counter (Binary)
// Incrementing a binary counter — amortized O(1) per increment
// Even though worst case single increment = O(n bits)

struct BinaryCounter {
    var bits: [Int]

    init(size: Int) {
        bits = [Int](repeating: 0, count: size)
    }

    // Worst case O(n) but amortized O(1)
    mutating func increment() {
        var i = bits.count - 1
        while i >= 0 && bits[i] == 1 {
            bits[i] = 0   // flip 1 → 0
            i -= 1
        }
        if i >= 0 {
            bits[i] = 1   // flip 0 → 1
        }
    }

    // Amortized Analysis:
    // bit[0] flips every increment         → n times
    // bit[1] flips every 2nd increment     → n/2 times
    // bit[2] flips every 4th increment     → n/4 times
    // Total flips = n + n/2 + n/4 + ... = 2n = O(n)
    // Per increment = O(n) / n = O(1) amortized
}

// MARK: - Example 4: Swift Dictionary Resize
// Similar to dynamic array — rehashing is O(n) but rare
// Amortized insert = O(1)

func dictionaryAmortizedExample() {
    var dict = [Int: String]()

    // Each insert is O(1) amortized
    // Occasionally rehashes entire table = O(n) but rare
    for i in 0..<100 {
        dict[i] = "value_\(i)"
    }

    print("Total entries: \(dict.count)")
}

// MARK: - Amortized vs Average vs Worst Case
/*
 
 WORST CASE    → single operation in worst scenario
                 e.g. append when resize needed = O(n)

 AVERAGE CASE  → expected cost across random inputs
                 e.g. average search in hash table = O(1)

 AMORTIZED     → average cost per operation over a
                 SEQUENCE of operations
                 e.g. append over many calls = O(1) amortized

 Key Difference:
 Average case  → about random inputs
 Amortized     → about sequence of operations (no randomness)

*/

// MARK: - Quick Reference
/*

 Operation                    | Worst Case | Amortized
 -----------------------------|------------|----------
 Swift Array append()         | O(n)       | O(1)
 Swift Dictionary insert      | O(n)       | O(1)
 Swift Set insert             | O(n)       | O(1)
 Stack push/pop               | O(1)       | O(1)
 Binary counter increment     | O(n)       | O(1)

*/
