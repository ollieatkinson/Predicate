import Foundation

prefix public func ! <T>(predicate: Predicate.Predicate<T>) -> Predicate.Predicate<T>

public func != <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Equatable

public func && <T>(lhs: Predicate.Predicate<T>, rhs: Predicate.Predicate<T>) -> CompoundPredicate<T>

public func && <T>(lhs: Predicate.Predicate<T>, rhs: @autoclosure @escaping () -> Bool) -> CompoundPredicate<T>

public func && <T>(lhs: @autoclosure @escaping () -> Bool, rhs: Predicate.Predicate<T>) -> CompoundPredicate<T>

public func < <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Comparable

public func << <Root>(keyPath: KeyPath<Root, Int>, value: ClosedRange<Int>) -> Predicate.Predicate<Root>

public func << <Root, Value>(keyPath: KeyPath<Root, Value>, value: [Value]) -> Predicate.Predicate<Root> where Value : Equatable

public func <= <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Comparable

public func == <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Equatable

public func > <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Comparable

public func >= <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate.Predicate<Root> where Value : Comparable

public typealias CompoundPredicate<Object> = Predicate.Predicate<Object>

public struct KeyPathPartialPredicate<Object, Value> {

    public let keyPath: KeyPath<Object, Value>

    public init(keyPath: KeyPath<Object, Value>)
}

extension KeyPathPartialPredicate where Value : Equatable {

    public func equal(value: Value) -> Predicate.Predicate<Object>

    public func notEqual(value: Value) -> Predicate.Predicate<Object>
}

extension KeyPathPartialPredicate where Value : Equatable {

    public func included(in array: [Value]) -> Predicate.Predicate<Object>
}

extension KeyPathPartialPredicate where Value : Comparable {

    public func lessThan(value: Value) -> Predicate.Predicate<Object>

    public func moreThan(value: Value) -> Predicate.Predicate<Object>

    public func lessThanOrEqualTo(value: Value) -> Predicate.Predicate<Object>

    public func moreThanOrEqualTo(value: Value) -> Predicate.Predicate<Object>
}

extension KeyPathPartialPredicate where Value == Int {

    public func inRange(of range: ClosedRange<Int>) -> Predicate.Predicate<Object>
}

extension KeyPathPartialPredicate where Value == String {

    public func matches(regex: Predicate.Regex) -> Predicate.Predicate<Object>
}

public struct Predicate<Object> {

    public func evaluate(with object: Object) -> Bool
}

extension Predicate : ExpressibleByBooleanLiteral {

    public init(booleanLiteral value: Bool)
}

extension Predicate {

    public var not: Predicate.Predicate<Object> { get }
}

extension Predicate {

    public func and(_ other: Predicate.Predicate<Object>) -> Predicate.Predicate<Object>

    public func or(_ other: Predicate.Predicate<Object>) -> Predicate.Predicate<Object>
}

public struct Regex {

    public let pattern: String

    public let options: NSString.CompareOptions

    public init(pattern: String, options: NSString.CompareOptions)
}

extension Regex : ExpressibleByStringLiteral {

    public init(stringLiteral value: String)

    public init(unicodeScalarLiteral value: String)

    public init(extendedGraphemeClusterLiteral value: String)
}

public func || <T>(lhs: @autoclosure @escaping () -> Bool, rhs: Predicate.Predicate<T>) -> CompoundPredicate<T>

public func || <T>(lhs: Predicate.Predicate<T>, rhs: @autoclosure @escaping () -> Bool) -> CompoundPredicate<T>

public func || <T>(lhs: Predicate.Predicate<T>, rhs: Predicate.Predicate<T>) -> CompoundPredicate<T>

public func ~= <Root>(keyPath: KeyPath<Root, String>, regex: Predicate.Regex) -> Predicate.Predicate<Root>

extension Sequence {

    public func filter(_ predicate: Predicate.Predicate<Self.Element>) -> [Self.Element]

    public func prefix(while predicate: Predicate.Predicate<Self.Element>) -> Self.SubSequence

    public func drop(while predicate: Predicate.Predicate<Self.Element>) -> Self.SubSequence
}

