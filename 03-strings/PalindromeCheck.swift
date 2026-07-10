import Foundation

// ============================================
// Problem: Palindrome Check
// ============================================
// A palindrome is a string that reads the same
// forward and backward.
//
// Example 1:
// Input:  "racecar"
// Output: true
//
// Example 2:
// Input:  "hello"
// Output: false
//
// Example 3:
// Input:  "A man a plan a canal Panama"
// Output: true  → "amanaplanacanalpanama"
//
// Constraints:
// - May contain spaces, punctuation, mixed case
// ============================================

// MARK: - Approach 1: Built-in Reverse
// Compare string with its reverse
// Time: O(n) | Space: O(n)

func isPalindromeBuiltIn(_ s: String) -> Bool {
    return s == String(s.reversed())
}

// MARK: - Approach 2: Two Pointers (Optimal)
// Compare characters from both ends moving inward
// Time: O(n) | Space: O(1)

func isPalindromeTwoPointers(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] != chars[right] { return false }
        left += 1
        right -= 1
    }
    return true
}

// MARK: - Approach 3: Valid Palindrome (Alphanumeric Only)
// ============================================
// Ignore non-alphanumeric characters and case
// Classic LeetCode #125
//
// Example:
// Input:  "A man, a plan, a canal: Panama"
// Output: true  → "amanaplanacanalpanama"
//
// Input:  "race a car"
// Output: false → "raceacar"
// ============================================

// Time: O(n) | Space: O(1)
func isValidPalindrome(_ s: String) -> Bool {
    let chars = Array(s.lowercased())
    var left = 0
    var right = chars.count - 1

    while left < right {
        // Skip non alphanumeric from left
        while left < right && !chars[left].isLetter && !chars[left].isNumber {
            left += 1
        }

        // Skip non alphanumeric from right
        while left < right && !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
        }

        if chars[left] != chars[right] { return false }

        left += 1
        right -= 1
    }
    return true
}

// MARK: - Approach 4: Palindrome Check Recursive
// Recursively compare outer characters moving inward
// Time: O(n) | Space: O(n) — call stack

func isPalindromeRecursive(_ s: String) -> Bool {
    let chars = Array(s)
    return checkPalindrome(chars, left: 0, right: chars.count - 1)
}

private func checkPalindrome(_ chars: [Character], left: Int, right: Int) -> Bool {
    if left >= right { return true }
    if chars[left] != chars[right] { return false }
    return checkPalindrome(chars, left: left + 1, right: right - 1)
}

// MARK: - Bonus: Longest Palindromic Substring
// ============================================
// Find the longest palindromic substring
//
// Example:
// Input:  "babad"
// Output: "bab" or "aba"
//
// Input:  "cbbd"
// Output: "bb"
//
// Pattern: Expand Around Center
// Time: O(n²) | Space: O(1)
// ============================================

func longestPalindrome(_ s: String) -> String {
    let chars = Array(s)
    var start = 0
    var maxLength = 0

    for i in 0..<chars.count {
        // Odd length palindromes — single center
        let odd = expandAroundCenter(chars, left: i, right: i)

        // Even length palindromes — double center
        let even = expandAroundCenter(chars, left: i, right: i + 1)

        let currentMax = max(odd, even)

        if currentMax > maxLength {
            maxLength = currentMax
            // Calculate start index of palindrome
            start = i - (currentMax - 1) / 2
        }
    }
    let end = start + maxLength
    return String(chars[start..<end])
}

private func expandAroundCenter(_ chars: [Character], left: Int, right: Int) -> Int {
    var l = left
    var r = right

    while l >= 0 && r < chars.count && chars[l] == chars[r] {
        l -= 1
        r += 1
    }
    return r - l - 1    // length of palindrome
}

// MARK: - Bonus: Valid Palindrome II
// ============================================
// Return true if string can become palindrome
// by removing AT MOST one character
//
// Example:
// Input:  "abca"
// Output: true  → remove 'c' → "aba"
//
// Input:  "abc"
// Output: false
// ============================================

// Time: O(n) | Space: O(1)
func validPalindromeII(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] != chars[right] {
            // Try skipping left OR right character
            return isPalindromeRange(chars, left + 1, right) ||
                   isPalindromeRange(chars, left, right - 1)
        }
        left += 1
        right -= 1
    }
    return true
}

private func isPalindromeRange(_ chars: [Character], _ left: Int, _ right: Int) -> Bool {
    var l = left
    var r = right

    while l < r {
        if chars[l] != chars[r] { return false }
        l += 1
        r -= 1
    }
    return true
}

// MARK: - Test Cases

// Approach 1
print(isPalindromeBuiltIn("racecar"))       // true
print(isPalindromeBuiltIn("hello"))         // false
print(isPalindromeBuiltIn("madam"))         // true

// Approach 2
print(isPalindromeTwoPointers("racecar"))   // true
print(isPalindromeTwoPointers("hello"))     // false

// Approach 3
print(isValidPalindrome("A man, a plan, a canal: Panama"))  // true
print(isValidPalindrome("race a car"))                      // false
print(isValidPalindrome(" "))                               // true

// Approach 4
print(isPalindromeRecursive("racecar"))     // true
print(isPalindromeRecursive("hello"))       // false

// Bonus: Longest Palindromic Substring
print(longestPalindrome("babad"))           // "bab" or "aba"
print(longestPalindrome("cbbd"))            // "bb"
print(longestPalindrome("racecar"))         // "racecar"

// Bonus: Valid Palindrome II
print(validPalindromeII("abca"))            // true
print(validPalindromeII("abc"))             // false
print(validPalindromeII("deeee"))           // true

// MARK: - Complexity Analysis
/*
 Built-in Reverse:
   Time  → O(n)  — reversed() + comparison
   Space → O(n)  — new reversed string

 Two Pointers:
   Time  → O(n)  — single pass from both ends
   Space → O(1)  — only two pointer variables

 Valid Palindrome (Alphanumeric):
   Time  → O(n)  — single pass skipping non-alphanum
   Space → O(1)  — only pointer variables

 Recursive:
   Time  → O(n)  — n/2 recursive calls
   Space → O(n)  — call stack depth

 Expand Around Center:
   Time  → O(n²) — expand from each center
   Space → O(1)  — only pointer variables

 Valid Palindrome II:
   Time  → O(n)  — at most two passes
   Space → O(1)  — only pointer variables

 Key Insight:
 Two pointers is the go-to for palindrome problems.
 Start from both ends and move inward comparing chars.

 For "longest palindromic substring":
 Expand around center is cleaner than DP
 and uses O(1) space instead of O(n²).

 Always check:
 - Odd length palindromes  → single center character
 - Even length palindromes → two center characters
*/
