import Foundation

// ============================================
// Strings — Mixed Practice Problems
// Day 18 — Revision of all string patterns
// ============================================
// Patterns covered:
// - Two Pointers
// - Sliding Window
// - Hashing / Frequency Map
// - String Builder
// - Expand Around Center
// ============================================

// MARK: - Problem 1: First Unique Character
// ============================================
// Find index of first non-repeating character
//
// Example:
// Input:  "leetcode"
// Output: 0  → 'l' appears once
//
// Input:  "aabb"
// Output: -1  → no unique character
//
// Pattern: Frequency Map
// Time: O(n) | Space: O(1)
// ============================================

func firstUniqueCharacter(_ s: String) -> Int {
    let chars = Array(s)
    var freq = [Character: Int]()

    // Count frequency of each character
    for char in chars {
        freq[char, default: 0] += 1
    }

    // Find first character with frequency 1
    for (i, char) in chars.enumerated() {
        if freq[char] == 1 { return i }
    }
    return -1
}

// MARK: - Problem 2: Roman to Integer
// ============================================
// Convert Roman numeral string to integer
//
// Example:
// Input:  "III"   → Output: 3
// Input:  "LVIII" → Output: 58
// Input:  "MCMXCIV" → Output: 1994
//
// Pattern: Hashing + String Traversal
// Time: O(n) | Space: O(1)
// ============================================

func romanToInt(_ s: String) -> Int {
    let romanValues: [Character: Int] = [
        "I": 1, "V": 5, "X": 10, "L": 50,
        "C": 100, "D": 500, "M": 1000
    ]

    let chars = Array(s)
    var total = 0

    for i in 0..<chars.count {
        let current = romanValues[chars[i]]!

        // If next value is greater → subtract current
        if i + 1 < chars.count && current < romanValues[chars[i + 1]]! {
            total -= current
        } else {
            total += current
        }
    }
    return total
}

// MARK: - Problem 3: Count and Say
// ============================================
// Generate nth term of count-and-say sequence
//
// 1 → "1"
// 2 → "11"       (one 1)
// 3 → "21"       (two 1s)
// 4 → "1211"     (one 2, one 1)
// 5 → "111221"   (one 1, one 2, two 1s)
//
// Pattern: String Builder
// Time: O(n * m) | Space: O(m)
// ============================================

func countAndSay(_ n: Int) -> String {
    var result = "1"

    for _ in 1..<n {
        let chars = Array(result)
        var next = ""
        var i = 0

        while i < chars.count {
            let currentChar = chars[i]
            var count = 1

            // Count consecutive same characters
            while i + count < chars.count && chars[i + count] == currentChar {
                count += 1
            }

            next += "\(count)\(currentChar)"
            i += count
        }
        result = next
    }
    return result
}

// MARK: - Problem 4: Longest Common Prefix
// ============================================
// Find longest common prefix among array of strings
//
// Example:
// Input:  ["flower","flow","flight"]
// Output: "fl"
//
// Input:  ["dog","racecar","car"]
// Output: ""
//
// Pattern: Vertical Scanning
// Time: O(n * m) | Space: O(1)
// ============================================

func longestCommonPrefix(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }

    let firstChars = Array(strs[0])

    for i in 0..<firstChars.count {
        for str in strs {
            let chars = Array(str)

            // Check if index exists and chars match
            if i >= chars.count || chars[i] != firstChars[i] {
                return String(firstChars[0..<i])
            }
        }
    }
    return strs[0]
}

// MARK: - Problem 5: String Compression
// ============================================
// Compress string using counts of repeated characters
//
// Example:
// Input:  ["a","a","b","b","c","c","c"]
// Output: 6  → array becomes ["a","2","b","2","c","3"]
//
// Pattern: Two Pointers
// Time: O(n) | Space: O(1)
// ============================================

func compress(_ chars: inout [Character]) -> Int {
    var write = 0   // position to write compressed chars
    var read = 0    // position to read original chars

    while read < chars.count {
        let currentChar = chars[read]
        var count = 0

        // Count consecutive same characters
        while read < chars.count && chars[read] == currentChar {
            read += 1
            count += 1
        }

        // Write character
        chars[write] = currentChar
        write += 1

        // Write count if more than 1
        if count > 1 {
            for digit in String(count) {
                chars[write] = digit
                write += 1
            }
        }
    }
    return write
}

// MARK: - Problem 6: Isomorphic Strings
// ============================================
// Two strings are isomorphic if characters
// can be mapped consistently to each other
//
// Example:
// Input:  s = "egg", t = "add"   → true  (e→a, g→d)
// Input:  s = "foo", t = "bar"   → false (o→a and o→r conflict)
// Input:  s = "paper", t = "title" → true
//
// Pattern: Two Hash Maps
// Time: O(n) | Space: O(1)
// ============================================

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    let sChars = Array(s)
    let tChars = Array(t)

    var sToT = [Character: Character]()
    var tToS = [Character: Character]()

    for i in 0..<sChars.count {
        let sc = sChars[i]
        let tc = tChars[i]

        // Check s → t mapping
        if let mapped = sToT[sc], mapped != tc { return false }
        sToT[sc] = tc

        // Check t → s mapping (ensure bijection)
        if let mapped = tToS[tc], mapped != sc { return false }
        tToS[tc] = sc
    }
    return true
}

// MARK: - Problem 7: Reverse Vowels of a String
//
