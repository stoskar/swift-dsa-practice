# 📘 Arrays

## What is an Array?
An array is a collection of elements stored in **contiguous memory**.
Each element is accessible by its **index** in O(1) time.

---

## ⏱️ Time Complexity — Swift Array

| Operation | Complexity | Notes |
|-----------|------------|-------|
| Access by index | O(1) | Direct memory access |
| Search (unsorted) | O(n) | Must check every element |
| Search (sorted) | O(log n) | Binary search |
| Insert at end | O(1) amortized | append() |
| Insert at index | O(n) | Shifts all elements after |
| Delete at end | O(1) | removeLast() |
| Delete at index | O(n) | Shifts all elements after |

---

## 🧠 Key Patterns to Master

| Pattern | When to Use |
|---------|------------|
| Two Pointers | Sorted array, pair problems |
| Sliding Window | Subarray, substring problems |
| Prefix Sum | Range sum queries |
| Kadane's Algorithm | Maximum subarray |

---

## 📁 Problems in This Folder

| File | Problem | Difficulty | Pattern |
|------|---------|------------|---------|
| TwoSum.swift | Find two numbers that add to target | Easy | Hashing |
| MaxSubarray.swift | Largest sum contiguous subarray | Easy | Kadane's |
| SlidingWindow.swift | Max sum subarray of size k | Easy | Sliding Window |
| TwoPointers.swift | Two pointer technique examples | Easy | Two Pointers |
| PrefixSum.swift | Range sum queries | Easy | Prefix Sum |

---

## 💡 Swift Array Tips

```swift
// Declaration
var arr = [Int]()
var arr2 = [1, 2, 3, 4, 5]

// Common operations
arr2.append(6)           // O(1) — add to end
arr2.insert(0, at: 0)   // O(n) — add at index
arr2.removeLast()        // O(1) — remove from end
arr2.remove(at: 0)       // O(n) — remove at index
arr2.sorted()            // O(n log n)
arr2.reversed()          // O(n)
arr2.filter { $0 > 2 }  // O(n)
arr2.map { $0 * 2 }     // O(n)

// Two pointer setup
var left = 0
var right = arr2.count - 1

// Sliding window setup
var windowStart = 0
var windowSum = 0
```

---

## 🗓️ Days Covered: 6–12
## ✅ Status: In Progress
