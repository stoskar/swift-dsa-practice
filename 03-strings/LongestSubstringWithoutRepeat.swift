import Foundation

// ============================================
// Problem: Longest Substring Without Repeating Characters
// ============================================
// Given a string, find the length of the longest
// substring without repeating characters.
//
// Example 1:
// Input:  "abcabcbb"
// Output: 3  → "abc"
//
// Example 2:
// Input:  "bbbbb"
// Output: 1  → "b"
//
// Example 3:
// Input:  "pwwkew"
// Output: 3  → "wke"
//
// Constraints:
// - String can contain letters, digits, symbols, spaces
// ============================================

// MARK: - Approach 1: Brute Force
// Check every possible substring
// Time: O(n³) | Space: O(n)

func lengthOfLongestSubstringBrute(_ s: String) -> Int {
    let chars = Array(s)
    var maxLength = 0

    for i in 0..<chars.count {
        for j in i..<chars.count {
            let substring = Array(chars[i...j])
            if Set(substring).count == substring.count {
                maxLength = max(maxLength, substring.count)
            }
        }
    }
    return maxLength
}

// MARK: - Approach 2: Sliding Window with Set
// Expand window right, shrink left when duplicate found
// Time: O(n) | Space: O(n)

func lengthOfLongestSubstringSet(_ s: String) -> Int {
    let chars = Array(s)
    var seen = Set<Character>()
    var maxLength = 0
    var left = 0

    for right in 0..<chars.count {
        // Shrink window until no duplicate
        while seen.contains(chars[right]) {
            seen.remove(chars[left])
            left += 1
        }

        seen.insert(chars[right])
        maxLength = max(maxLength, right - left + 1)
    }
    return maxLength
}

// MARK: - Approach 3: Sliding Window with Dictionary (Optimal)
// Jump left pointer directly to duplicate position
// Time: O(n) | Space: O(n)

func lengthOfLongestSubstringDict(_ s: String) -> Int {
    let chars = Array(s)
    var lastSeen = [Character: Int]()   // char: last index seen
    var maxLength = 0
    var left = 0

    for right in 0..<chars.count {
        let char = chars[right]

        // If char was seen inside current window
        // jump left pointer past its last occurrence
        if let lastIndex = lastSeen[char], lastIndex >= left {
            left = lastIndex + 1
        }

        lastSeen[char] = right
        maxLength = max(maxLength, right - left + 1)
    }
    return maxLength
}

// MARK: - Approach 4: Sliding Window with Array (Most Efficient)
// Use fixed array of 128 for ASCII characters
// Time: O(n) | Space: O(1) — fixed size array

func lengthOfLongestSubstringArray(_ s: String) -> Int {
    let chars = Array(s)
    var index = [Int](repeating: -1, count: 128)  // ASCII size
    var maxLength = 0
    var left = 0

    for right in 0..<chars.count {
        let ascii = Int(chars[right].asciiValue!)

        // Jump left if character was seen in current window
        if index[ascii] >= left {
            left = index[ascii] + 1
        }

        index[ascii] = right
        maxLength = max(maxLength, right - left + 1)
    }
    return maxLength
}

// MARK: - Bonus: Longest Substring with At Most K Distinct Characters
// ============================================
// Find longest substring with at most k distinct characters
//
// Example:
// Input:  "eceba", k = 2
// Output: 3  → "ece"
//
// Pattern: Sliding Window + HashMap
// Time: O(n) | Space: O(k)
// ============================================

func lengthOfLongestSubstringKDistinct(_ s: String, k: Int) -> Int {
    guard k > 0 else { return 0 }

    let chars = Array(s)
    var freq = [Character: Int]()
    var maxLength = 0
    var left = 0

    for right in 0..<chars.count {
        // Add right character to window
        freq[chars[right], default: 0] += 1

        // Shrink window if distinct chars exceeds k
        while freq.count > k {
            let leftChar = chars[left]
            freq[leftChar]! -= 1
            if freq[leftChar] == 0 {
                freq.removeValue(forKey: leftChar)
            }
            left += 1
        }

        maxLength = max(maxLength, right - left + 1)
    }
    return maxLength
}

// MARK: - Bonus: Longest Substring with At Most 2 Distinct Characters
// ============================================
// Special case of above where k = 2
//
// Example:
// Input:  "ccaabbb"
// Output: 5  → "aabbb"
// ============================================

func lengthOfLongestSubstringTwoDistinct(_ s: String) -> Int {
    return lengthOfLongestSubstringKDistinct(s, k: 2)
}

// MARK: - Test Cases

// Approach 1
print(lengthOfLongestSubstringBrute("abcabcbb"))    // 3
print(lengthOfLongestSubstringBrute("bbbbb"))       // 1

// Approach 2
print(lengthOfLongestSubstringSet("abcabcbb"))      // 3
print(lengthOfLongestSubstringSet("pwwkew"))        // 3

// Approach 3
print(lengthOfLongestSubstringDict("abcabcbb"))     // 3
print(lengthOfLongestSubstringDict(""))             // 0
print(lengthOfLongestSubstringDict(" "))            // 1

// Approach 4
print(lengthOfLongestSubstringArray("abcabcbb"))    // 3
print(lengthOfLongestSubstringArray("dvdf"))        // 3

// Bonus: K Distinct
print(lengthOfLongestSubstringKDistinct("eceba", k: 2))     // 3
print(lengthOfLongestSubstringKDistinct("aa", k: 1))        // 2

// Bonus: Two Distinct
print(lengthOfLongestSubstringTwoDistinct("ccaabbb"))       // 5

// MARK: - Complexity Analysis
/*
 Brute Force:
   Time  → O(n³) — two loops + set check per substring
   Space → O(n)  — set stores substring characters

 Sliding Window with Set:
   Time  → O(n)  — each char added/removed at most once
   Space → O(n)  — set stores window characters

 Sliding Window with Dictionary:
   Time  → O(n)  — single pass, jump left directly
   Space → O(n)  — dictionary stores last seen index

 Sliding Window with Array:
   Time  → O(n)  — single pass
   Space → O(1)  — fixed array of size 128

 Key Insight:
 The trick is knowing WHEN to move the left pointer.
 
 With Set    → move left one step at a time until no duplicate
 With Dict   → jump left directly past last duplicate position
               this avoids unnecessary iterations
 
 Dict approach is better than Set approach because:
 "abba" → when right hits second 'a':
 Set  → removes b, b, a one by one (3 steps)
 Dict → jumps left directly to index 1 (1 step)

 When to use Sliding Window:
 - Longest/shortest substring with condition
 - No repeating characters problems
 - At most k distinct characters problems
*/
