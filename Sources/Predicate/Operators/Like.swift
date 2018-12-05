#if canImport(Foundation)
import Foundation
#endif

// MARK:- ClosedRange

public func << <Root>(keyPath: KeyPath<Root, Int>, value: ClosedRange<Int>) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).inRange(of: value)
}

// MARK:- Array

public func << <Root, Value: Equatable>(keyPath: KeyPath<Root, Value>, value: [Value]) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).included(in: value)
}

// MARK:- Regex

#if canImport(Foundation)

public func ~= <Root>(keyPath: KeyPath<Root, String>, regex: Regex) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).matches(regex: regex)
}

public struct Regex {
    
    public let pattern: String
    public let options: NSString.CompareOptions
    
    public init(pattern: String, options: NSString.CompareOptions) {
        self.pattern = pattern
        self.options = options.union(.regularExpression)
    }
    
}

extension Regex: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(pattern: value, options: .regularExpression)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(pattern: value, options: .regularExpression)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(pattern: value, options: .regularExpression)
    }
    
}

#endif
