import Foundation

// ============================================
// Hash Map Basics in Swift
// ============================================
// Covering core dictionary and set operations
// that form the foundation of hashing problems
// ============================================

// MARK: - Dictionary (Hash Map) Basics

func dictionaryBasics() {

    // MARK: Creation
    var dict1 = [String: Int]()                     // empty
    var dict2 = ["a": 1, "b": 2, "c": 3]           // with values
    let dict3: [Int: String] = [1: "one", 2: "two"] // typed

    // MARK: Insert & Update
    dict1["apple"] = 10         // insert
    dict1["apple"] = 20         // update — overwrites
    dict1.updateValue(30, forKey: "apple")  // same as above

    // MARK: Access
    let val1 = dict2["a"]           // Optional(1)
    let val2 = dict2["z"]           // nil — key doesn't exist
    let val3 = dict2["z"] ?? 0      // 0 — safe default

    // MARK: Safe Increment (most used in DSA)
    var freq = [Character: Int]()
    let str = "hello"
    for char in str {
        freq[char, default: 0] += 1
    }
    // freq = ["h":1, "e":1, "l":2, "o":1]

    // MARK: Check Existence
    let exists = dict2["a"] != nil  // true
    let hasKey = dict2.keys.contains("a")  // true

    // MARK: Delete
    dict2.removeValue(forKey: "a")  // removes key "a"
    dict2["b"] = nil                // also removes key "b"

    // MARK: Iterate
    for (key, value) in dict3 {
        print("\(key): \(value)")
    }

    // Iterate only keys
    for key in dict3.keys { print(key) }

    // Iterate only values
    for value in dict3.values { print(value) }

    // MARK: Useful Properties
    print(dict3.count)      // number of key-value pairs
    print(dict3.isEmpty)    // true if empty
    print(dict3.keys)       // all keys
    print(dict3.values)     // all values
}

// MARK: - Set (Hash Set) Basics

func setBasics() {

    // MARK: Creation
    var set1 = Set<Int>()               // empty
    var set2: Set = [1, 2, 3, 4, 5]    // with values
    let set3 = Set([1, 2, 2, 3, 3])    // duplicates removed → {1,2,3}

    // MARK: Insert & Delete
    set1.insert(10)
    set1.insert(20)
    set1.insert(10)     // ignored — already exists
    set1.remove(10)     // removes 10

    // MARK: Lookup O(1)
    print(set2.contains(3))     // true
    print(set2.contains(99))    // false

    // MARK: Set Operations
    let a: Set = [1, 2, 3, 4]
    let b: Set = [3, 4, 5, 6]

    print(a.union(b))           // {1, 2, 3, 4, 5, 6}
    print(a.intersection(b))    // {3, 4}
    print(a.subtracting(b))     // {1, 2}
    print(a.symmetricDifference(b)) // {1, 2, 5, 6}

    // MARK: Subset & Superset
    let c: Set = [1, 2]
    print(c.isSubset(of: a))    // true
    print(a.isSuperset(of: c))  // true

    // MARK: Convert between Array and Set
    let arr = [1, 2, 2, 3, 3, 4]
    let uniqueSet = Set(arr)            // remove duplicates
    let backToArr = Array(uniqueSet)    // back to array (unordered)
}

// MARK: - Common DSA Patterns Using HashMap

// Pattern 1: Frequency Counter
func frequencyCounter(_ nums: [Int]) -> [Int: Int] {
    var freq = [Int: Int]()
    for num in nums {
        freq[num, default: 0] += 1
    }
    return freq
}

// Pattern 2: Two Sum — store complement
func twoSumHash(_ nums: [Int], target: Int) -> [Int] {
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

// Pattern 3: Check Duplicate — using Set
func hasDuplicate(_ nums: [Int]) -> Bool {
    var seen = Set<Int>()
    for num in nums {
        if seen.contains(num) { return true }
        seen.insert(num)
    }
    return false
}

// Pattern 4: Group by Property
func groupByRemainder(_ nums: [Int], k: Int) -> [Int: [Int]] {
    var groups = [Int: [Int]]()
    for num in nums {
        let key = num % k
        groups[key, default: []].append(num)
    }
    return groups
}

// Pattern 5: Count Distinct Elements
func countDistinct(_ nums: [Int]) -> Int {
    return Set(nums).count
}

// Pattern 6: First Recurring Element
func firstRecurring(_ nums: [Int]) -> Int? {
    var seen = Set<Int>()
    for num in nums {
        if seen.contains(num) { return num }
        seen.insert(num)
    }
    return nil
}

// Pattern 7: Intersection using Set
func arrayIntersection(_ a: [Int], _ b: [Int]) -> [Int] {
    let setA = Set(a)
    return b.filter { setA.contains($0) }
}

// MARK: - Test Cases

// Frequency Counter
print(frequencyCounter([1, 2, 2, 3, 3, 3]))
// [1:1, 2:2, 3:3]

// Two Sum
print(twoSumHash([2, 7, 11, 15], target: 9))
// [0, 1]

// Has Duplicate
print(hasDuplicate([1, 2, 3, 1]))    // true
print(hasDuplicate([1, 2, 3, 4]))    // false

// Group by Remainder
print(groupByRemainder([1, 2, 3, 4, 5, 6], k: 3))
// [0:[3,6], 1:[1,4], 2:[2,5]]

// Count Distinct
print(countDistinct([1, 2, 2, 3, 3, 3]))    // 3

// First Recurring
print(firstRecurring([2, 5, 1, 2, 3, 5]))   // Optional(2)
print(firstRecurring([1, 2, 3, 4]))          // nil

// Array Intersection
print(arrayIntersection([1, 2, 3, 4], [2, 4, 6]))  // [2, 4]

// MARK: - Complexity Summary
/*
 Operation              Dictionary    Set
 ───────────────────────────────────────
 Insert                 O(1) avg      O(1) avg
 Delete                 O(1) avg      O(1) avg
 Search/Lookup          O(1) avg      O(1) avg
 Iterate                O(n)          O(n)

 Key Insight:
 Hash Map → when you need key-value pairs
 Hash Set → when you only need existence checks

 Most common DSA use cases:
 - Frequency counting    → dict[key, default:0] += 1
 - Seen before check     → Set.contains()
 - Index mapping         → dict[value] = index
 - Grouping              → dict[key, default:[]].append()
 - Remove duplicates     → Set(array)
*/
