import Foundation

// ============================================
// Problem: Best Time to Buy and Sell Stock
// ============================================
// Given an array of prices where prices[i] is the
// price of a stock on day i, find the maximum profit
// from ONE buy and ONE sell.
//
// Example:
// Input:  [7, 1, 5, 3, 6, 4]
// Output: 5  → buy on day 2 (price=1), sell on day 5 (price=6)
//
// Constraints:
// - Must buy before selling
// - Only one transaction allowed
// - Return 0 if no profit possible
// ============================================

// MARK: - Approach 1: Brute Force
// Check every pair of buy/sell days
// Time: O(n²) | Space: O(1)

func maxProfitBrute(_ prices: [Int]) -> Int {
    var maxProfit = 0

    for i in 0..<prices.count {
        for j in i + 1..<prices.count {
            let profit = prices[j] - prices[i]
            maxProfit = max(maxProfit, profit)
        }
    }
    return maxProfit
}

// MARK: - Approach 2: One Pass (Optimal)
// Track minimum price seen so far
// At each day calculate profit if sold today
// Time: O(n) | Space: O(1)

func maxProfitOptimal(_ prices: [Int]) -> Int {
    var minPrice = Int.max
    var maxProfit = 0

    for price in prices {
        if price < minPrice {
            minPrice = price        // found new cheapest buy day
        } else {
            let profit = price - minPrice
            maxProfit = max(maxProfit, profit)  // best profit so far
        }
    }
    return maxProfit
}

// MARK: - Approach 3: Two Pointers
// Left pointer = buy day, right pointer = sell day
// Time: O(n) | Space: O(1)

func maxProfitTwoPointers(_ prices: [Int]) -> Int {
    var left = 0    // buy pointer
    var right = 1   // sell pointer
    var maxProfit = 0

    while right < prices.count {
        if prices[left] < prices[right] {
            // Profitable trade
            let profit = prices[right] - prices[left]
            maxProfit = max(maxProfit, profit)
        } else {
            // Found cheaper buy day
            left = right
        }
        right += 1
    }
    return maxProfit
}

// MARK: - Bonus: Best Time to Buy and Sell Stock II
// ============================================
// Multiple transactions allowed
// Can buy and sell on same day
//
// Example:
// Input:  [7, 1, 5, 3, 6, 4]
// Output: 7  → buy day2 sell day3 (profit=4)
//             + buy day4 sell day5 (profit=3)
// ============================================

// Time: O(n) | Space: O(1)
func maxProfitMultiple(_ prices: [Int]) -> Int {
    var totalProfit = 0

    for i in 1..<prices.count {
        // Grab every upward price movement
        if prices[i] > prices[i - 1] {
            totalProfit += prices[i] - prices[i - 1]
        }
    }
    return totalProfit
}

// MARK: - Test Cases

// Single transaction
let prices1 = [7, 1, 5, 3, 6, 4]
print(maxProfitOptimal(prices1))          // 5
print(maxProfitTwoPointers(prices1))      // 5

let prices2 = [7, 6, 4, 3, 1]
print(maxProfitOptimal(prices2))          // 0 — no profit possible

let prices3 = [1, 2]
print(maxProfitOptimal(prices3))          // 1

let prices4 = [2, 4, 1, 7]
print(maxProfitOptimal(prices4))          // 6 → buy at 1 sell at 7

// Multiple transactions
print(maxProfitMultiple(prices1))         // 7
print(maxProfitMultiple(prices2))         // 0

// MARK: - Complexity Analysis
/*
 Brute Force:
   Time  → O(n²) — check every buy/sell pair
   Space → O(1)  — only variables

 One Pass (Optimal):
   Time  → O(n)  — single pass tracking min price
   Space → O(1)  — two variables only

 Two Pointers:
   Time  → O(n)  — left/right scan forward
   Space → O(1)  — two pointer variables

 Key Insight:
 We don't need to try every pair.
 Track the minimum price seen so far.
 At each price, profit = currentPrice - minPrice.
 Keep track of the maximum such profit.

 Why Two Pointers works:
 If prices[right] < prices[left] → left = right
 because buying at a lower price always beats
 buying at a higher price regardless of sell day.
*/
