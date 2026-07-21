import Foundation

// ============================================
// Group Anagrams Pattern
// ============================================
// Group strings that are anagrams of each other.
//
// Core Idea:
// Two strings are anagrams if they have the same
// characters in different order.
// → Sorting both gives the same key
// → Use sorted string as hash map key to group them
//
// Example:
// Input:  ["eat","tea","tan","ate","nat","bat"]
// Output: [["eat","tea","ate"], ["tan","nat"], ["bat"]]
// ============================================

// MARK: - Approach 1: Sort as Key (Most Common)
// Sort each string → use as dictionary key
// Time: O(n * k log k) | Space: O(n * k)
// n = number of strings, k = max string length

func groupAnagramsSort(_ strs: [String]) -> [[String]] {
    var groups = [String: [String]]()

    for str in strs {
        // Sorted string is the key
        let key = String(str.sorted())
        groups[key, default: []].append(str)
    }

    return Array(groups.values)
}

// MARK: - Approach 2: Character Count as Key
// Use character frequency array as key
// Time: O(n * k) | Space: O(n * k)
// Faster than sorting when k is large

func groupAnagramsCount(_ strs: [String]) -> [[String]] {
    var groups = [String: [String]]()

    for str in strs {
        // Build frequency array of size 26
        var count = [Int](repeating: 0, count: 26)
        let aScalar = Character("a").asciiValue!

        for char in str {
            count[Int(char.asciiValue! - aScalar)] += 1
        }

        // Convert count array to string key
        // e.g "eat" → "1#0#0#0#1#0#0#0#0#0#0#0#0#0#0#0#0#0#0#1#0#0#0#0#0#0"
        let key = count.map { String($0) }.joined(separator: "#")
        groups[key, default: []].append(str)
    }

    return Array(groups.values)
}

// MARK: - Problem 2: Valid Anagram Check
// ============================================
// Check if two strings are anagrams
//
// Example:
// Input:  s = "anagram", t = "nagaram"
// Output: true
//
// Time: O(n) | Space: O(1)
// ============================================

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var freq = [Character: Int]()

    for char in s { freq[char, default: 0] += 1 }
    for char in t {
        freq[char, default: 0] -= 1
        if freq[char]! < 0 { return false }
    }
    return true
}

// MARK: - Problem 3: Find Anagram Mappings
// ============================================
// Given two arrays where nums2 is anagram of nums1,
// return mapping array where mapping[i] = index of
// nums1[i] in nums2
//
// Example:
// Input:  nums1 = [12,28,46,32,50], nums2 = [50,12,32,46,28]
// Output: [1, 4, 3, 2, 0]
//
// Time: O(n) | Space: O(n)
// ============================================

func anagramMappings(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    // Build index map for nums2
    var indexMap = [Int: Int]()
    for (i, num) in nums2.enumerated() {
        indexMap[num] = i
    }

    // Map each element in nums1 to its index in nums2
    return nums1.map { indexMap[$0]! }
}

// MARK: - Problem 4: Minimum Number of Steps
// ============================================
// Given two strings, return minimum number of
// character replacements to make them anagrams
//
// Example:
// Input:  s = "bab", t = "aba"
// Output: 1  → replace 'b' with 'a' in s or vice versa
//
// Time: O(n) | Space: O(1)
// ============================================

func minStepsToAnagram(_ s: String, _ t: String) -> Int {
    var freq = [Character: Int]()

    // Increment for s characters
    for char in s { freq[char, default: 0] += 1 }

    // Decrement for t characters
    for char in t { freq[char, default: 0] -= 1 }

    // Count positive values — characters s has extra
    return freq.values.filter { $0 > 0 }.reduce(0, +)
}

// MARK: - Problem 5: Group Shifted Strings
// ============================================
// Group strings that belong to same shifting sequence
// A string can be shifted by moving each character
// to next letter cyclically
//
// Example:
// "abc" → "bcd" → "xyz" → "yza" (same group)
// "az" → "ba" (same group)
//
// Input:  ["abc","bcd","acef","xyz","az","ba","a","z"]
// Output: [["acef"],["a","z"],["abc","bcd","xyz"],["az","ba"]]
//
// Time: O(n * k) | Space: O(n * k)
// ============================================

func groupStrings(_ strings: [String]) -> [[String]] {
    var groups = [String: [String]]()

    for str in strings {
        let chars = Array(str)
        var key = ""

        // Calculate shift differences between consecutive chars
        for i in 1..<chars.count {
            let diff = (Int(chars[i].asciiValue!) -
                       Int(chars[i-1].asciiValue!) + 26) % 26
            key += "\(diff)#"
        }

        groups[key, default: []].append(str)
    }

    return Array(groups.values)
}

// MARK: - Problem 6: Largest Group
// ============================================
// Numbers from 1 to n grouped by digit sum.
// Return count of groups with largest size.
//
// Example:
// Input:  n = 13
// Output: 4
// → groups: {1:[1,10], 2:[2,11], 3:[3,12], 4:[4,13],
//             5:[5], 6:[6], 7:[7], 8:[8], 9:[9]}
// → largest size = 2, count = 4 groups
//
// Time: O(n * log n) | Space: O(n)
// ============================================

func countLargestGroup(_ n: Int) -> Int {
    var groups = [Int: Int]()

    for i in 1...n {
        // Calculate digit sum
        let digitSum = String(i).compactMap { $0.wholeNumberValue }.reduce(0, +)
        groups[digitSum, default: 0] += 1
    }

    let maxSize = groups.values.max()!
    return groups.values.filter { $0 == maxSize }.count
}

// MARK: - Test Cases

// Approach 1
let result1 = groupAnagramsSort(["eat","tea","tan","ate","nat","bat"])
print(result1.map { $0.sorted() }.sorted(by: { $0[0] < $1[0] }))
// [["ate","eat","tea"], ["bat"], ["nat","tan"]]

// Approach 2
let result2 = groupAnagramsCount(["eat","tea","tan","ate","nat","bat"])
print(result2.map { $0.sorted() }.sorted(by: { $0[0] < $1[0] }))
// [["ate","eat","tea"], ["bat"], ["nat","tan"]]

// Problem 2
print(isAnagram("anagram", "nagaram"))      // true
print(isAnagram("rat", "car"))              // false

// Problem 3
print(anagramMappings([12,28,46,32,50], [50,12,32,46,28]))
// [1, 4, 3, 2, 0]

// Problem 4
print(minStepsToAnagram("bab", "aba"))      // 1
print(minStepsToAnagram("leetcode", "practice"))    // 5

// Problem 5
let result5 = groupStrings(["abc","bcd","acef","xyz","az","ba","a","z"])
print(result5.sorted(by: { $0.count > $1.count }))
// [["abc","bcd","xyz"],["az","ba"],["acef"],["a","z"]]

// Problem 6
print(countLargestGroup(13))    // 4
print(countLargestGroup(2))     // 2

// MARK: - Complexity Summary
/*
 Approach                   Time          Space     Key
 ──────────────────────────────────────────────────────────────
 Group Anagrams (Sort)      O(n*k log k)  O(n*k)   sorted str
 Group Anagrams (Count)     O(n*k)        O(n*k)   freq array
 Valid Anagram              O(n)          O(1)     freq map
 Anagram Mappings           O(n)          O(n)     index map
 Min Steps to Anagram       O(n)          O(1)     freq diff
 Group Shifted Strings      O(n*k)        O(n*k)   diff key
 Largest Group              O(n log n)    O(n)     digit sum

 Core Grouping Pattern:
 ──────────────────────
 var groups = [String: [String]]()
 for str in strs {
     let key = String(str.sorted())     ← compute key
     groups[key, default: []].append(str) ← group by key
 }
 return Array(groups.values)

 Key Insight:
 Anagram grouping = find a canonical form
 that all anagrams share as their key.

 Two canonical forms:
 - Sorted string  → "eat" → "aet" (simple, O(k log k))
 - Freq array     → "eat" → "1#0#0#0#1#0...#1" (faster O(k))

 Use freq array when:
 → strings are very long
 → charset is known and bounded (a-z)
*/
