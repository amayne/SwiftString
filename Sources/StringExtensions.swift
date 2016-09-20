//
//  SwiftString.swift
//  SwiftString
//
//  Created by Andrew Mayne on 30/01/2016.
//  Copyright © 2016 Red Brick Labs. All rights reserved.
//
import Foundation

public extension String {

    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of:left), let rightRange = range(of: right, options: .backwards),
				left != right && leftRange.upperBound != rightRange.lowerBound
            else { return nil }

		return self[leftRange.upperBound...index(before: rightRange.lowerBound)]

    }
    
    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    func camelize() -> String {
        let source = clean(with: " ", allOf: "-", "_")
        if source.characters.contains(" ") {
			let first = self[self.startIndex...self.index(after: startIndex)] //source.substringToIndex(source.index(after: startIndex))
            let cammel = NSString(format: "%@", (source as NSString).capitalized.replacingOccurrences(of: " ", with: "")) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
			let first = source[self.startIndex...self.index(after: startIndex)].lowercased()
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    func capitalize() -> String {
        return capitalized
    }
    
//    func contains(_ substring: String) -> Bool {
//        return range(of: substring) != nil
//    }

    func chompLeft(_ prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return self[startIndex..<prefixRange.lowerBound]
            } else {
                return self[prefixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func chompRight(_ suffix: String) -> String {
		if let suffixRange = range(of: suffix, options: .backwards) {
            if suffixRange.upperBound >= endIndex {
                return self[startIndex..<suffixRange.lowerBound]
            } else {
                return self[suffixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let thecomponents = components(separatedBy: NSCharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return thecomponents.joined(separator: " ")
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count-1
    }
    
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(_ prefix: String) -> String {
        if startsWith(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(_ suffix: String) -> String {
        if endsWith(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
    func indexOf(_ substring: String) -> Int? {
        if let range = range(of: substring) {
			return self.distance(from: startIndex, to: range.lowerBound)
//            return startIndex.distanceTo(range.lowerBound)
        }
        return nil
    }
    
    func initials() -> String {
        let words = self.components(separatedBy: " ")
		return words.reduce(""){$0 + $1[startIndex...startIndex]}
//		return words.reduce(""){$0 + $1[0...0]}
    }
    
    func initialsFirstAndLast() -> String {
		let words = self.components(separatedBy: " ")
        return words.reduce("") { ($0 == "" ? "" : $0[startIndex...startIndex]) + $1[startIndex...startIndex]}
    }
    
    func isAlpha() -> Bool {
        for chr in characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphaNumeric() -> Bool {
        let alphaNumeric = NSCharacterSet.alphanumerics
		let output = self.unicodeScalars.split { !alphaNumeric.contains($0)}.map(String.init)
		if output.count == 1 {
			if output[0] != self {
				return false
			}
		}
		return output.count == 1
//        return componentsSeparatedByCharactersInSet(alphaNumeric).joinWithSeparator("").length == 0
    }
    
    func isEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).length == 0
    }
    
    func isNumeric() -> Bool {
        if let _ = defaultNumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    private func join<S: Sequence>(_ elements: S) -> String {
        return elements.map{String(describing: $0)}.joined(separator: self)
    }

    func latinize() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
//		stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: NSLocale.currentLocale())
    }
    
    func lines() -> [String] {
        return self.components(separatedBy: NSCharacterSet.newlines)
    }
    
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func pad(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self, string.times(n)])
    }
    
    func padLeft(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self])
    }
    
    func padRight(_ n: Int, _ string: String = " ") -> String {
        return "".join([self, string.times(n)])
    }
    
    func slugify(withSeparator separator: Character = "-") -> String {
        let slugCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\(separator)")
        return latinize()
            .lowercased()
            .components(separatedBy: slugCharacterSet.inverted)
            .filter { $0 != "" }
            .joined(separator: String(separator))
    }
    
    func split(_ separator: Character = " ") -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    func startsWith(_ prefix: String) -> Bool {
        return hasPrefix(prefix)
    }

    func stripPunctuation() -> String {
        return components(separatedBy: .punctuationCharacters)
            .joined(separator: "")
            .components(separatedBy: " ")
            .filter { $0 != "" }
            .joined(separator: " ")
    }
    
    func times(_ n: Int) -> String {
        return (0..<n).reduce("") { $0.0 + self }
    }
    
    func toFloat() -> Float? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
        
    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercased()
		return (trimmed as NSString).boolValue
    }
    
    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        return dateFormatter(format).date(from: self) as Date?
    }
    
    func toDateTime(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return toDate(format)
    }
    
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        return self
    }
    
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines.inverted, options: NSString.CompareOptions.backwards) {
            return self[startIndex..<range.upperBound]
        }
        return self
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return self[startIndex..<endIndex]
        }
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.characters.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }    
}

private enum ThreadLocalIdentifier {
    case dateFormatter(String)

    case defaultNumberFormatter
    case localeNumberFormatter(NSLocale)

    var objcDictKey: String {
        switch self {
        case .dateFormatter(let format):
            return "SS\(self)\(format)"
        case .localeNumberFormatter(let l):
            return "SS\(self)\(l.localeIdentifier)"
        default:
            return "SS\(self)"
        }
    }
}

private func threadLocalInstance<T: AnyObject>(_ identifier: ThreadLocalIdentifier, initialValue: @autoclosure () -> T) -> T {
    let storage = Thread.current.threadDictionary
    let k = identifier.objcDictKey

    let instance: T = storage[k] as? T ?? initialValue()
    if storage[k] == nil {
        storage[k] = instance
    }

    return instance
}

private func dateFormatter(_ format: String) -> DateFormatter {
    return threadLocalInstance(.dateFormatter(format), initialValue: {
        let df = DateFormatter()
        df.dateFormat = format
        return df
    }())
}

private func defaultNumberFormatter() -> NumberFormatter {
    return threadLocalInstance(.defaultNumberFormatter, initialValue: NumberFormatter())
}

private func localeNumberFormatter(_ locale: NSLocale) -> NumberFormatter {
    return threadLocalInstance(.localeNumberFormatter(locale), initialValue: {
        let nf = NumberFormatter()
        nf.locale = locale as Locale!
        return nf
    }())
}
