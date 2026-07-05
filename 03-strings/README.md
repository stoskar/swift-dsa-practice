# 📘 Strings

## What is a String?
A string is a sequence of characters stored in memory.
In Swift, `String` is a value type with powerful built-in methods.

---

## ⏱️ Time Complexity — Swift String

| Operation | Complexity | Notes |
|-----------|------------|-------|
| Access by index | O(n) | Swift strings are not random access |
| Search substring | O(n*m) | n = string length, m = pattern length |
| Append character | O(1) amortized | append() |
| Count characters | O(n) | Swift counts grapheme clusters |
| Concatenation | O(n) | Creates new string |
| Convert to Array | O(n) | Array(string) |

> ⚠️ Key Swift Note: Unlike other languages, Swift strings
> do NOT support integer indexing directly (str[0] won't work).
> Use String.Index or convert to Array first.

---

## 🧠 Key Patterns to Master

| Pattern | When to Use |
|---------|------------|
| Two Pointers | Palindrome, reverse, comparison |
| Sliding Window | Longest substring problems |
| Hashing / Frequency Map | Anagram, character count problems |
| String Builder | Avoid repeated concatenation |

---

## 💡 Swift String Tips

```swift
// Declaration
let str = "Hello, Swift"

// Convert to character array (enables index access)
let chars = Array(str)          // ['H','e','l','l','o',...]

// Iterate characters
for char in str { print(char) }

// Check if empty
str.isEmpty

// Length
str.count

// Reverse
String(str.reversed())

// Uppercase / Lowercase
str.uppercased()
str.lowercased()

// Contains
str.contains("Swift")

// Split
str.split(separator: ",")

// Frequency map
var freq = [Character: Int]()
for char in str {
    freq[char, default: 0] += 1
}

// Check if palindrome using two pointers
var chars = Array(str)
var left = 0
var right = chars.count - 1
while left < right {
    if chars[left] != chars[right] { break }
    left += 1
    right -= 1
}

// String from characters array
let result = String(chars)
```

---

## 📁 Problems in This Folder

| File | Problem | Difficulty | Pattern |
|------|---------|------------|---------|
| ReverseString.swift | Reverse a string in place | Easy | Two Pointers |
| ValidAnagram.swift | Check if two strings are anagrams | Easy | Hashing |
| LongestSubstringWithoutRepeat.swift | Longest substring without repeating chars | Medium | Sliding Window |
| PalindromeCheck.swift | Check if string is palindrome | Easy | Two Pointers |
| PracticeProblems.swift | Mixed string problems | Easy/Medium | Mixed |

---

## 🗓️ Days Covered: 14–18
