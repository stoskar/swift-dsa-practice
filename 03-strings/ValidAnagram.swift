import Foundation

// ============================================
// Problem: Valid Anagram
// ============================================
// Given two strings s and t, return true if t
// is an anagram of s, and false otherwise.
//
// An anagram is a word formed by rearranging
// the letters of another word using all
// original letters exactly once.
//
// Example 1:
// Input:  s = "anagram", t = "nagaram"
// Output: true
//
// Example 2:
// Input:  s = "rat", t = "car"
// Output: false
//
// Constraints:
// - Strings consist of lowercase English letters
// ============================================

// MARK: - Approach 1: Sorting
// Sort both strings and compare
// Time: O(n log n) | Space: O(n)

func isAnagramSorting(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    return s.sorted() == t.sorted()
}

// MARK: - Approach 2: Frequency Map (Optimal)
// Count character frequency in both strings
// Time: O(n) | Space: O(1) — at most 26 keys
//
// Key insight:
// Two strings are anagrams if they have
// exactly the same character frequencies

func isAnagramFrequency(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var freq = [Character: Int]()

    // Increment for characters in s
    for char in s {
        freq[char, default: 0] += 1
    }

    // Decrement for characters in t
    for char in t {
        freq[char, default: 0] -= 1

        // Early exit if count goes negative
        if freq[char]! < 0 { return false }
    }
    return true
}

// MARK: - Approach 3: Single Dictionary Check
// Build frequency map for s, verify against t
// Time: O(n) | Space: O(1)

func isAnagramSingleDict(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var freq = [Character: Int]()

    for char in s { freq[char, default: 0] += 1 }
    for char in t { freq[char, default: 0] -= 1 }

    // All values must be zero for anagram
    return freq.values.allSatisfy { $0 == 0 }
}

// MARK: - Approach 4: Array of 26 (Most Efficient)
// Use fixed array of size 26 instead of dictionary
// Time: O(n) | Space: O(1) — fixed size array

func isAnagramArray(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var count = [Int](repeating: 0, count: 26)
    let aScalar = Character("a").asciiValue!

    for char in s {
        count[Int(char.asciiValue! - aScalar)] += 1
    }

    for char in t {
        count[Int(char.asciiValue! - aScalar)] -= 1
        if count[Int(char.asciiValue! - aScalar)] < 0 {
            return false
        }
    }
    return true
}

// MARK: - Bonus: Group Anagrams
// ============================================
// Group array of strings into anagram groups
//
// Example:
// Input:  ["eat","tea","tan","ate","nat","bat"]
// Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
//
// Pattern: Hashing with sorted key
// Time: O(n * k log k) | Space: O(n * k)
// n = number of strings, k = max string length
// ============================================

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var groups = [String: [String]]()

    for str in strs {
        // Sorted string as key — anagrams have same sorted form
        let key = String(str.sorted())
        groups[key, default: []].append(str)
    }

    return Array(groups.values)
}

// MARK: - Bonus: Valid Anagram with Unicode
// ============================================
// Handle strings with any unicode characters
// not just lowercase English letters
//
// Example:
// Input:  s = "anagram", t = "nagaram"
// Output: true
// ============================================

func isAnagramUnicode(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var freq = [Character: Int]()

    for char in s { freq[char, default: 0] += 1 }
    for char in t {
        freq[char, default: 0] -= 1
        if freq[char]! < 0 { return false }
    }
    return true
}

// MARK: - Test Cases

// Approach 1
print(isAnagramSorting("anagram", "nagaram"))   // true
print(isAnagramSorting("rat", "car"))           // false
print(isAnagramSorting("listen", "silent"))     // true

// Approach 2
print(isAnagramFrequency("anagram", "nagaram")) // true
print(isAnagramFrequency("rat", "car"))         // false

// Approach 3
print(isAnagramSingleDict("anagram", "nagaram"))// true
print(isAnagramSingleDict("a", "ab"))           // false

// Approach 4
print(isAnagramArray("anagram", "nagaram"))     // true
print(isAnagramArray("rat", "car"))             // false

// Group Anagrams
let result = groupAnagrams(["eat","tea","tan","ate","nat","bat"])
print(result)
// [["bat"], ["tan","nat"], ["eat","tea","ate"]] (order may vary)

// MARK: - Complexity Analysis
/*
 Sorting:
   Time  → O(n log n) — sorting both strings
   Space → O(n)       — sorted copy of strings

 Frequency Map (Dictionary):
   Time  → O(n)  — two passes through strings
   Space → O(1)  — at most 26 keys for English letters

 Array of 26:
   Time  → O(n)  — two passes through strings
   Space → O(1)  — fixed array of size 26

 Group Anagrams:
   Time  → O(n * k log k) — sort each string as key
   Space → O(n * k)       — store all strings in groups

 Key Insight:
 Two strings are anagrams if and only if their
 character frequency maps are identical.

 Array[26] vs Dictionary:
 Array[26] is faster in practice because:
 - No hashing overhead
 - Fixed memory size
 - Cache friendly access
 - Works when charset is known (a-z)
 Use Dictionary when charset is unknown (unicode)
*/
