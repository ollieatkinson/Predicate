# Predicate.swift

[![Build Status](https://travis-ci.com/ollieatkinson/Predicate.swift.svg?branch=master)](https://travis-ci.com/ollieatkinson/Predicate.swift) 
[![Swift 5.2](https://img.shields.io/badge/swift-5.1-ED523F.svg?style=flat)](https://swift.org/download/) 
[![SPM](https://img.shields.io/badge/swift-SPM-ED523F.svg?style=flat)](https://swift.org/package-manager/)
![SPM](https://img.shields.io/badge/os-linux-lightgrey.svg?style=flat)
![macOS](https://img.shields.io/badge/os-macOS-lightgrey.svg?style=flat)
[![Licence](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat)](LICENCE)

Predicate composition for filtering operators (eg. `filter`, `prefix(while:)` or `drop(while:)`).

## API

### Equals
```swift
public func == <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Equatable
public func != <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Equatable
```

#### Example
```swift
users.filter(\.name == "Milos")
users.filter(\.name != "Ste")
```

### Less Than & More Than
```swift
public func < <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Comparable
public func <= <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Comparable
public func > <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Comparable
public func >= <Root, Value>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> where Value : Comparable
```

#### Example
```swift
users.filter(\.age > 25)
users.filter(\.age <= 55)
```

### Similar to

```swift
public func << <Root>(keyPath: KeyPath<Root, Int>, value: ClosedRange<Int>) -> Predicate<Root>
public func << <Root, Value>(keyPath: KeyPath<Root, Value>, value: [Value]) -> Predicate<Root> where Value : Equatable
public func ~= <Root>(keyPath: KeyPath<Root, String>, regex: Regex) -> Predicate<Root>
public func == <Root, Value>(keyPath: KeyPath<Root, Value>, value: ClosedRange<Value>) -> Predicate<Root> where Value : FloatingPoint
public func ± <T>(number: T, accuracy: T) -> ClosedRange<T> where T : FloatingPoint
```

#### Example
```swift
users.filter(\.age << 30...35) // Age is within the range 30-35
users.filter(\.age << [ 30, 32, 34 ]) // Age is one of 30, 32 or 34
users.filter(\.weight == 85 ± 4 //Weight is equal to 85, plus or minus 4, useful for comparing floating points where accuracy is not important
```

### Boolean Logic

Combine any of the previous logic together to compose more complex predicates

```swift
public func && <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T>
public func && <T>(lhs: Predicate<T>, rhs: @autoclosure @escaping () -> Bool) -> CompoundPredicate<T>
public func && <T>(lhs: @autoclosure @escaping () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T>
public func || <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T>
public func || <T>(lhs: Predicate<T>, rhs: @autoclosure @escaping () -> Bool) -> CompoundPredicate<T>
public func || <T>(lhs: @autoclosure @escaping () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T>
public prefix func ! <T>(predicate: Predicate<T>) -> Predicate<T>
public prefix func ! <Root>(keyPath: KeyPath<Root, Bool>) -> Predicate<Root>
```

#### Example

```swift
users.filter(\.isClearToFly && \.name == "Noah")
users.filter(\.age > 30 && \.name != "Noah")
```

### Sequences

```swift
extension Sequence {
    public func filter(_ predicate: Predicate<Element>) -> [Element]
    public func prefix(while predicate: Predicate<Element>) -> [Element]
    public func drop(while predicate: Predicate<Element>) -> DropWhileSequence<Self>
    public func first(where predicate: Predicate<Element>) -> Element?
    public func contains(where predicate: Predicate<Element>) -> Bool
    public func allSatisfy(_ predicate: Predicate<Element>) -> Bool
}
```

# Installation

## SwiftPM:

```swift
package.append(.package(url: "https://github.com/ollieatkinson/Predicate.swift", from: "1.0.0"))
```
