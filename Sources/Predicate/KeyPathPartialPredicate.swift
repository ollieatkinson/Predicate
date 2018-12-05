public struct KeyPathPartialPredicate<Object, Value> {
    
    public let keyPath: KeyPath<Object, Value>
    
    public init(keyPath: KeyPath<Object, Value>) {
        self.keyPath = keyPath
    }
    
}

// MARK:- Equatable

extension KeyPathPartialPredicate where Value: Equatable {
    
    public func equal(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, ==)
    }
    
    public func notEqual(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, !=)
    }
    
}

extension KeyPathPartialPredicate where Value: Equatable {
    
    public func included(in array: [Value]) -> Predicate<Object> {
        return Predicate<Object> { [unowned keyPath] object in
            array.contains(object[keyPath: keyPath])
        }
    }
    
}

// MARK:- Comparable

extension KeyPathPartialPredicate where Value: Comparable {
    
    public func lessThan(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, <)
    }
    
    public func moreThan(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, >)
    }
    
    public func lessThanOrEqualTo(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, <=)
    }
    
    public func moreThanOrEqualTo(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, >=)
    }
    
}

// MARK:- Int

extension KeyPathPartialPredicate where Value == Int {
    
    public func inRange(of range: ClosedRange<Int>) -> Predicate<Object> {
        return Predicate<Object> { [unowned keyPath] object in
            range.contains(object[keyPath: keyPath])
        }
    }
    
}

// MARK:- String - Regular Expression (Foundation)

#if canImport(Foundation)

import Foundation

extension KeyPathPartialPredicate where Value == String {
    
    public func matches(regex: Regex) -> Predicate<Object> {
        return Predicate<Object> { [unowned keyPath] object in
            object[keyPath: keyPath].range(of: regex.pattern, options: regex.options) != nil
        }
    }
    
}

#endif
