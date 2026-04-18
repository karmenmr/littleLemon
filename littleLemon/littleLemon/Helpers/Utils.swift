import Foundation

func isValid(email: String) -> Bool {
    let pattern = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    let matches = NSPredicate(format: "SELF MATCHES %@", pattern)
    return matches.evaluate(with: email)
}

func isValid(name: String) -> Bool {
    guard !name.isEmpty, name.count > 2 else { return false }
    let regexStr = /^[a-zA-Z ]*$/
    let regex = Regex(regexStr)
    if let matches = name.wholeMatch(of: regex) {
        return matches.count != 0
    }
    return false
}

func formatPhone(_ number: String) -> String {
    var formatted = ""
    if !number.isEmpty {
        let startIndex = number.index(number.startIndex, offsetBy: 3)
        let endIndex = number.index(number.endIndex, offsetBy: -4)
        formatted = "(\(number[number.startIndex..<startIndex]))"
        formatted += " \(number[startIndex..<endIndex])"
        formatted += "-\(number[endIndex..<number.endIndex])"
    }
    return formatted
}
