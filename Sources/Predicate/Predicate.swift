import Foundation

public func == <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Equatable {
    return { block($0) == value }
}

public func != <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Equatable {
    return { block($0) != value }
}

public func < <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Comparable {
    return { block($0) < value }
}

public func > <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Comparable {
    return { block($0) > value }
}

public func <= <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Comparable {
    return { block($0) <= value }
}

public func >= <Root, Value>(block: @escaping (Root) -> Value, value: Value) -> (Root) -> Bool where Value: Comparable {
    return { block($0) >= value }
}

public prefix func ! <Root>(block: @escaping (Root) -> Bool) -> (Root) -> Bool {
    return { !block($0) }
}

public func && <Root>(lhs: @escaping @autoclosure () -> Bool, rhs: @escaping (Root) -> Bool) -> (Root) -> Bool {
    return { lhs() && rhs($0) }
}

public func || <Root>(lhs: @escaping @autoclosure () -> Bool, rhs: @escaping (Root) -> Bool) -> (Root) -> Bool {
    return { lhs() || rhs($0) }
}

public func && <Root>(lhs: @escaping (Root) -> Bool, rhs: @escaping @autoclosure () -> Bool) -> (Root) -> Bool {
    return { lhs($0) && rhs() }
}

public func || <Root>(lhs: @escaping (Root) -> Bool, rhs: @escaping @autoclosure () -> Bool) -> (Root) -> Bool {
    return { lhs($0) || rhs() }
}

public func && <Root>(lhs: @escaping (Root) -> Bool, rhs: @escaping (Root) -> Bool) -> (Root) -> Bool {
    return { lhs($0) && rhs($0) }
}

public func || <Root>(lhs: @escaping (Root) -> Bool, rhs: @escaping (Root) -> Bool) -> (Root) -> Bool {
    return { lhs($0) || rhs($0) }
}

// MARK:- Sequence

public func << <Root, S>(block: @escaping (Root) -> S.Element, value: S) -> (Root) -> Bool where S: Sequence, S.Element: Equatable {
    return { value.contains(block($0)) }
}

// MARK:- Regex

public func ~= <Root>(block: @escaping (Root) -> String, regex: Regex) -> (Root) -> Bool {
    return { block($0).range(of: regex.pattern, options: regex.options) != nil }
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

public func == <Root, Value>(block: @escaping (Root) -> Value, value: (Value, Value)) -> (Root) -> Bool where Value: FloatingPoint {
    return { abs(block($0) - value.0) < value.1 }
}

infix operator ± : NilCoalescingPrecedence

public func ± <Value>(number: Value, accuracy: Value) -> (Value, Value) where Value: FloatingPoint {
    return (number, accuracy)
}
