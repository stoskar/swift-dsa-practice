import Foundation

// ============================================
// Problem: Reverse String
// ============================================
// Reverse a string in place using a character array.
// Must be done with O(1) extra space.
//
// Example:
// Input:  ["h","e","l","l","o"]
// Output: ["o","l","l","e","h"]
//
// Constraints:
// - Must modify input array in place
// - O(1) extra space only
// ============================================

// MARK: - Approach 1: Two Pointers (Optimal)
// Swap characters from both ends moving inward
// Time: O(n) | Space: O(1)

func reverseString(_ chars: inout [Character]) {
    var left = 0
    var right = chars.count - 1

    while left < right {
        chars.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// MARK: - Approach 2: Reverse a Swift String
// Using built-in reversed()
// Time: O(n) | Space: O(n)

func reverseStringBuiltIn(_ str: String) -> String {
    return String(str.reversed())
}

// MARK: - Approach 3: Reverse Words in a String
// ============================================
// Reverse the order of words in a sentence
//
// Example:
// Input:  "the sky is blue"
// Output: "blue is sky the"
// ============================================

// Time: O(n) | Space: O(n)
func reverseWords(_ str: String) -> String {
    let words = str
        .split(separator: " ")      // split by space
        .map(String.init)           // convert to [String]
        .reversed()                 // reverse order
    return words.joined(separator: " ")
}

// MARK: - Approach 4: Reverse Each Word in Place
// ============================================
// Reverse each individual word but keep word order
//
// Example:
// Input:  "Hello World"
// Output: "olleH dlroW"
// ============================================

// Time: O(n) | Space: O(n)
func reverseEachWord(_ str: String) -> String {
    let words = str.split(separator: " ").map(String.init)
    let reversed = words.map { String($0.reversed()) }
    return reversed.joined(separator: " ")
}

// MARK: - Approach 5: Reverse String Between Indices
// ============================================
// Reverse only a portion of the string
//
// Example:
// Input:  "abcdefg", left = 2, right = 5
// Output: "abfedcg"
// ============================================

// Time: O(n) | Space: O(n)
func reverseStringBetween(_ str: String, left: Int, right: Int) -> String {
    var chars = Array(str)
    var l = left
    var r = right

    while l < r {
        chars.swapAt(l, r)
        l += 1
        r -= 1
    }
    return String(chars)
}

// MARK: - Test Cases

// Approach 1
var chars1: [Character] = ["h", "e", "l", "l", "o"]
reverseString(&chars1)
print(chars1)                               // ["o", "l", "l", "e", "h"]

var chars2: [Character] = ["H", "a", "n", "n", "a", "h"]
reverseString(&chars2)
print(chars2)                               // ["h", "a", "n", "n", "a", "H"]

// Approach 2
print(reverseStringBuiltIn("Swift"))        // "tfiwS"
print(reverseStringBuiltIn("Hello"))        // "olleH"

// Approach 3
print(reverseWords("the sky is blue"))      // "blue is sky the"
print(reverseWords("hello world"))          // "world hello"

// Approach 4
print(reverseEachWord("Hello World"))       // "olleH dlroW"
print(reverseEachWord("Swift iOS"))         // "tfiwS SOi"

// Approach 5
print(reverseStringBetween("abcdefg", left: 2, right: 5))  // "abfedcg"

// MARK: - Complexity Analysis
/*
 Two Pointers In Place:
   Time  → O(n)  — single pass swapping elements
   Space → O(1)  — only two pointer variables

 Built-in reversed():
   Time  → O(n)  — creates reversed sequence
   Space → O(n)  — new string created

 Reverse Words:
   Time  → O(n)  — split + reverse + join
   Space → O(n)  — array of words

 Key Insight:
 Two pointer swap is the most efficient approach.
 left and right pointers move toward each other,
 swapping characters until they meet in the middle.

 Important Swift Note:
 Swift strings use String.Index not integers.
 Always convert to [Character] array first when
 you need index-based character manipulation.
*/
