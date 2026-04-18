import Foundation

func isValid(_ email: String) -> Bool {
    let pattern = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    let matches = NSPredicate(format: "SELF MATCHES %@", pattern)
    return matches.evaluate(with: email)
}
