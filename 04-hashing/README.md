# 📘 Hashing

## What is Hashing?
Hashing is a technique that maps data to a fixed-size
value (hash) using a hash function. It enables O(1)
average time for insert, delete, and search operations.

---

## ⏱️ Time Complexity — Swift Dictionary & Set

| Operation | Average Case | Worst Case | Notes |
|-----------|-------------|------------|-------|
| Insert | O(1) | O(n) | Worst case on hash collision |
| Delete | O(1) | O(n) | Worst case on hash collision |
| Search | O(1) | O(n) | Worst case on hash collision |
| Iterate | O(n) | O(n) | Always linear |

---

## 🧠 Key Concepts

### Hash Map (Dictionary in Swift)
```swift
// Key → Value pairs
var dict = [String: Int]()
dict["apple"] = 1
dict["banana"] = 2

// Access
let val = dict["apple"]         // Optional(1)
let val2 = dict["mango"] ?? 0   // 0 (default)

// Check existence
dict["apple"] != nil            // true

// Iterate
for (key, value) in dict {
    print("\(key): \(value)")
}

// Safe increment
dict["apple", default: 0] += 1
```

### Hash Set (Set in Swift)
```swift
// Unique values only
var set = Set<Int>()
set.insert(1)
set.insert(2)
set.insert(1)   // ignored — already exists

// Check membership O(1)
set.contains(1) // true

// Set operations
let a: Set = [1, 2, 3]
let b: Set = [2, 3, 4]
a.union(b)          // [1, 2, 3, 4]
a.intersection(b)   // [2, 3]
a.subtracting(b)    // [1]
```

---

## 🧠 Key Patterns to Master

| Pattern | When to Use |
|---------|------------|
| Frequency Map | Count occurrences of elements |
| Two Sum Pattern | Find pairs with target sum |
| Grouping | Group elements by common property |
| Existence Check | Check if element was seen before |
| Index Mapping | Map values to their indices |

---

## 📁 Problems in This Folder

| File | Problem | Difficulty | Pattern |
|------|---------|------------|---------|
| HashMapBasics.swift | Core hash map operations | Easy | HashMap |
| FrequencyCounter.swift | Count element frequencies | Easy | Frequency Map |
| TwoSumHashing.swift | Two sum using hash map | Easy | Index Mapping |
| GroupAnagrams.swift | Group strings by anagram | Medium | Grouping |
| LongestConsecutiveSequence.swift | Longest consecutive sequence | Medium | HashSet |
| PracticeProblems.swift | Mixed hashing problems | Easy/Medium | Mixed |

---

## 🗓️ Days Covered: 19–24
## ✅ Status: In Progress
