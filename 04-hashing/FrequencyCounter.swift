import Foundation

// ============================================
// Frequency Counter Pattern
// ============================================
// Frequency counter uses a hash map to count
// occurrences of elements in a collection.
//
// Replaces nested loops O(n²) with
// two separate loops O(n) + O(n) = O(n)
//
// Most common pattern in hashing problems.
// ============================================

// MARK: - Problem 1: Top K Frequent Elements
// ============================================
// Given array, return k most frequent elements
//
// Example:
// Input:  [1,1,1,2,2,3], k = 2
// Output: [1, 2]
//
// Pattern: Frequency Map + Sort
// Time: O(n log n) | Space: O(n)
// ============================================

func topKFrequent(_ nums: [Int], k: Int) -> [Int] {
    // Step 1: Build frequency map
    var freq = [Int: Int]()
    for num in nums {
        freq[num, default: 0] += 1
    }

    // Step 2: Sort by frequency descending
    let sorted = freq.sorted { $0.value > $1.value }

    // Step 3: Return top k keys
    return Array(sorted.prefix(k).map { $0.key })
}

// Optimal: Bucket Sort approach
// Time: O(n) | Space: O(n)
func topKFrequentBucket(_ nums: [Int], k: Int) -> [Int] {
    // Step 1: Build frequency map
    var freq = [Int: Int]()
    for num in nums {
        freq[num, default: 0] += 1
    }

    // Step 2: Bucket sort — index = frequency
    var buckets = [[Int]](repeating: [], count: nums.count + 1)
    for (num, count) in freq {
        buckets[count].append(num)
    }

    // Step 3: Collect top k from highest frequency buckets
    var result = [Int]()
    for i in stride(from: buckets.count - 1, through: 0, by: -1) {
        for num in buckets[i] {
            result.append(num)
            if result.count == k { return result }
        }
    }
    return result
}

// MARK: - Problem 2: Sort Characters By Frequency
// ============================================
// Sort string by character frequency descending
//
// Example:
// Input:  "tree"
// Output: "eert" or "eetr"  → e appears twice
//
// Input:  "cccaaa"
// Output: "cccaaa" or "aaaccc"
//
// Pattern: Frequency Map + Sort
// Time: O(n log n) | Space: O(n)
// ============================================

func frequencySort(_ s: String) -> String {
    // Step 1: Build frequency map
    var freq = [Character: Int]()
    for char in s {
        freq[char, default: 0] += 1
    }

    // Step 2: Sort by frequency descending
    let sorted = freq.sorted { $0.value > $1.value }

    // Step 3: Build result string
    var result = ""
    for (char, count) in sorted {
        result += String(repeating: char, count: count)
    }
    return result
}

// MARK: - Problem 3: Find All Anagrams in String
// ============================================
// Find all start indices of anagrams of p in s
//
// Example:
// Input:  s = "cbaebabacd", p = "abc"
// Output: [0, 6]
// → s[0..2] = "cba" is anagram of "abc"
// → s[6..8] = "bac" is anagram of "abc"
//
// Pattern: Sliding Window + Frequency Map
// Time: O(n) | Space: O(1)
// ============================================

func findAnagrams(_ s: String, _ p: String) -> [Int] {
    guard s.count >= p.count else { return [] }

    let sChars = Array(s)
    let pChars = Array(p)
    var result = [Int]()

    var pFreq = [Character: Int]()
    var windowFreq = [Character: Int]()

    // Build frequency map for p
    for char in pChars {
        pFreq[char, default: 0] += 1
    }

    // Build first window
    for i in 0..<pChars.count {
        windowFreq[sChars[i], default: 0] += 1
    }

    // Check first window
    if windowFreq == pFreq { result.append(0) }

    // Slide window
    for i in pChars.count..<sChars.count {
        // Add new character to window
        windowFreq[sChars[i], default: 0] += 1

        // Remove old character from window
        let oldChar = sChars[i - pChars.count]
        windowFreq[oldChar]! -= 1
        if windowFreq[oldChar] == 0 {
            windowFreq.removeValue(forKey: oldChar)
        }

        // Check if current window is anagram
        if windowFreq == pFreq {
            result.append(i - pChars.count + 1)
        }
    }
    return result
}

// MARK: - Problem 4: Degree of an Array
// ============================================
// Find length of smallest subarray with same
// degree as the whole array.
// Degree = highest frequency of any element.
//
// Example:
// Input:  [1, 2, 2, 3, 1]
// Output: 2  → [2, 2] has degree 2, length 2
//
// Pattern: Frequency Map + Index Tracking
// Time: O(n) | Space: O(n)
// ============================================

func findShortestSubArray(_ nums: [Int]) -> Int {
    var freq = [Int: Int]()         // element: count
    var firstSeen = [Int: Int]()    // element: first index
    var lastSeen = [Int: Int]()     // element: last index

    for (i, num) in nums.enumerated() {
        freq[num, default: 0] += 1
        if firstSeen[num] == nil { firstSeen[num] = i }
        lastSeen[num] = i
    }

    // Find degree
    let degree = freq.values.max()!

    // Find smallest subarray with same degree
    var minLength = nums.count
    for (num, count) in freq {
        if count == degree {
            let length = lastSeen[num]! - firstSeen[num]! + 1
            minLength = min(minLength, length)
        }
    }
    return minLength
}

// MARK: - Problem 5: Unique Number of Occurrences
// ============================================
// Return true if number of occurrences of each
// value in array are all unique
//
// Example:
// Input:  [1, 2, 2, 1, 1, 3]
// Output: true
// → 1 appears 3 times, 2 appears 2 times, 3 appears 1 time
// → all occurrence counts are unique
//
// Pattern: Frequency Map + Set
// Time: O(n) | Space: O(n)
// ============================================

func uniqueOccurrences(_ arr: [Int]) -> Bool {
    // Build frequency map
    var freq = [Int: Int]()
    for num in arr {
        freq[num, default: 0] += 1
    }

    // Check if all frequencies are unique
    let freqValues = Array(freq.values)
    return freqValues.count == Set(freqValues).count
}

// MARK: - Problem 6: Check if Two Strings Are Close
// ============================================
// Two strings are close if you can make one
// equal to other by:
// 1. Swapping any two existing characters
// 2. Transforming every occurrence of one
//    character into another
//
// Example:
// Input:  "abc", "bca"   → true
// Input:  "a", "aa"      → false
// Input:  "cabbba", "abbccc" → true
//
// Pattern: Frequency Map Comparison
// Time: O(n) | Space: O(1)
// ============================================

func closeStrings(_ word1: String, _ word2: String) -> Bool {
    guard word1.count == word2.count else { return false }

    var freq1 = [Character: Int]()
    var freq2 = [Character: Int]()

    for char in word1 { freq1[char, default: 0] += 1 }
    for char in word2 { freq2[char, default: 0] += 1 }

    // Same set of unique characters
    guard Set(freq1.keys) == Set(freq2.keys) else { return false }

    // Same multiset of frequencies
    return freq1.values.sorted() == freq2.values.sorted()
}

// MARK: - Test Cases

// Problem 1
print(topKFrequent([1,1,1,2,2,3], k: 2))           // [1, 2]
print(topKFrequentBucket([1,1,1,2,2,3], k: 2))     // [1, 2]
print(topKFrequent([1], k: 1))                      // [1]

// Problem 2
print(frequencySort("tree"))                        // "eert" or "eetr"
print(frequencySort("cccaaa"))                      // "cccaaa" or "aaaccc"
print(frequencySort("Aabb"))                        // "bbAa"

// Problem 3
print(findAnagrams("cbaebabacd", "abc"))            // [0, 6]
print(findAnagrams("abab", "ab"))                   // [0, 1, 2]

// Problem 4
print(findShortestSubArray([1, 2, 2, 3, 1]))        // 2
print(findShortestSubArray([1, 2, 2, 3, 1, 4, 2])) // 6

// Problem 5
print(uniqueOccurrences([1, 2, 2, 1, 1, 3]))        // true
print(uniqueOccurrences([1, 2]))                    // false

// Problem 6
print(closeStrings("abc", "bca"))                   // true
print(closeStrings("a", "aa"))                      // false
print(closeStrings("cabbba", "abbccc"))             // true

// MARK: - Complexity Summary
/*
 Problem                        Time        Space
 ────────────────────────────────────────────────
 Top K Frequent (Sort)          O(n log n)  O(n)
 Top K Frequent (Bucket)        O(n)        O(n)
 Sort Characters By Frequency   O(n log n)  O(n)
 Find All Anagrams              O(n)        O(1)
 Degree of Array                O(n)        O(n)
 Unique Occurrences             O(n)        O(n)
 Close Strings                  O(n)        O(1)

 Key Insight:
 Frequency counter is about COUNTING then COMPARING.

 Common steps:
 1. Build frequency map → dict[key, default:0] += 1
 2. Compare frequencies → sorted values, sets, max
 3. Use result → top k, anagram check, degree

 Bucket Sort trick:
 When frequency is bounded by n (array size),
 use bucket sort for O(n) instead of O(n log n)
 buckets[frequency].append(element)
*/
