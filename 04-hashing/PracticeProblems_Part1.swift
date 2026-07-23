import Foundation

// ============================================
// Hashing — Mixed Practice Problems Part 1
// Day 24 — Revision of all hashing patterns
// ============================================
// Patterns covered:
// - Frequency Map
// - Two Sum Pattern
// - HashSet Cycle Detection
// - Bijection Mapping
// - Index Tracking
// ============================================

// MARK: - Problem 1: Happy Number
// ============================================
// A happy number eventually reaches 1 when
// replaced repeatedly by sum of squares of digits
//
// Example:
// Input:  19
// Output: true
// → 1² + 9² = 82
// → 8² + 2² = 68
// → 6² + 8² = 100
// → 1² + 0² + 0² = 1 
//
// Pattern: HashSet cycle detection
// Time: O(log n) | Space: O(log n)
// ============================================

func isHappy(_ n: Int) -> Bool {
    var seen = Set<Int>()
    var current = n

    while current != 1 {
        if seen.contains(current) { return false }
        seen.insert(current)
        current = sumOfSquares(current)
    }
    return true
}

private func sumOfSquares(_ n: Int) -> Int {
    var num = n
    var sum = 0
    while num > 0 {
        let digit = num % 10
        sum += digit * digit
        num /= 10
    }
    return sum
}

// MARK: - Problem 2: Ransom Note
// ============================================
// Return true if ransomNote can be constructed
// using letters from magazine
//
// Example:
// Input:  ransomNote = "aa", magazine = "aab"
// Output: true
//
// Input:  ransomNote = "aa", magazine = "ab"
// Output: false
//
// Pattern: Frequency Map
// Time: O(n) | Space: O(1)
// ============================================

func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var freq = [Character: Int]()

    for char in magazine {
        freq[char, default: 0] += 1
    }

    for char in ransomNote {
        freq[char, default: 0] -= 1
        if freq[char]! < 0 { return false }
    }
    return true
}

// MARK: - Problem 3: Word Pattern
// ============================================
// Check if string follows the same pattern
//
// Example:
// Input:  pattern = "abba", s = "dog cat cat dog"
// Output: true
//
// Input:  pattern = "abba", s = "dog cat cat fish"
// Output: false
//
// Pattern: Two Hash Maps (bijection)
// Time: O(n) | Space: O(n)
// ============================================

func wordPattern(_ pattern: String, _ s: String) -> Bool {
    let words = s.split(separator: " ").map(String.init)
    let chars = Array(pattern)

    guard chars.count == words.count else { return false }

    var charToWord = [Character: String]()
    var wordToChar = [String: Character]()

    for (char, word) in zip(chars, words) {
        if let mapped = charToWord[char], mapped != word {
            return false
        }
        charToWord[char] = word

        if let mapped = wordToChar[word], mapped != char {
            return false
        }
        wordToChar[word] = char
    }
    return true
}

// MARK: - Problem 4: Jewels and Stones
// ============================================
// Count how many stones are jewels
//
// Example:
// Input:  jewels = "aA", stones = "aAAbbbb"
// Output: 3
//
// Pattern: HashSet lookup
// Time: O(n) | Space: O(n)
// ============================================

func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
    let jewelSet = Set(jewels)
    return stones.filter { jewelSet.contains($0) }.count
}

// MARK: - Problem 5: Contains Nearby Duplicate
// ============================================
// Return true if two same values exist within
// distance k of each other
//
// Example:
// Input:  [1,2,3,1], k = 3
// Output: true  → nums[0] == nums[3], distance = 3
//
// Input:  [1,2,3,1,2,3], k = 2
// Output: false
//
// Pattern: HashMap index tracking
// Time: O(n) | Space: O(n)
// ============================================

func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    var lastSeen = [Int: Int]()

    for (i, num) in nums.enumerated() {
        if let lastIndex = lastSeen[num], i - lastIndex <= k {
            return true
        }
        lastSeen[num] = i
    }
    return false
}

// MARK: - Problem 6: Number of Good Pairs
// ============================================
// Count pairs (i,j) where nums[i] == nums[j] and i < j
//
// Example:
// Input:  [1,2,3,1,1,3]
// Output: 4  → (0,3),(0,4),(3,4),(2,5)
//
// Pattern: Frequency Map
// Time: O(n) | Space: O(n)
// ============================================

func numIdenticalPairs(_ nums: [Int]) -> Int {
    var freq = [Int: Int]()
    var count = 0

    for num in nums {
        count += freq[num, default: 0]
        freq[num, default: 0] += 1
    }
    return count
}

// MARK: - Test Cases

// Problem 1
print(isHappy(19))                              // true
print(isHappy(2))                               // false

// Problem 2
print(canConstruct("aa", "aab"))                // true
print(canConstruct("aa", "ab"))                 // false

// Problem 3
print(wordPattern("abba", "dog cat cat dog"))   // true
print(wordPattern("abba", "dog cat cat fish"))  // false
print(wordPattern("aaaa", "dog cat cat dog"))   // false

// Problem 4
print(numJewelsInStones("aA", "aAAbbbb"))       // 3
print(numJewelsInStones("z", "ZZ"))             // 0

// Problem 5
print(containsNearbyDuplicate([1,2,3,1], 3))    // true
print(containsNearbyDuplicate([1,2,3,1,2,3], 2))// false

// Problem 6
print(numIdenticalPairs([1,2,3,1,1,3]))         // 4
print(numIdenticalPairs([1,1,1,1]))             // 6

// MARK: - Complexity Summary
/*
 Problem                    Pattern              Time       Space
 ──────────────────────────────────────────────────────────────
 Happy Number               HashSet cycle        O(log n)   O(log n)
 Ransom Note                Frequency Map        O(n)       O(1)
 Word Pattern               Two HashMaps         O(n)       O(n)
 Jewels and Stones          HashSet              O(n)       O(n)
 Contains Nearby Duplicate  HashMap index        O(n)       O(n)
 Number of Good Pairs       Frequency Map        O(n)       O(n)
*/
