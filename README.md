# Predicate.swift

[![Build Status](https://travis-ci.com/ollieatkinson/Predicate.swift.svg?branch=master)](https://travis-ci.com/ollieatkinson/Predicate.swift) 
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-ED523F.svg?style=flat)](https://swift.org/download/) 
[![SPM](https://img.shields.io/badge/swift-SPM-ED523F.svg?style=flat)](https://swift.org/package-manager/)
![SPM](https://img.shields.io/badge/os-linux-lightgrey.svg?style=flat)
![macOS](https://img.shields.io/badge/os-macOS-lightgrey.svg?style=flat)
[![Licence](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat)](LICENCE)

Predicate composition for filtering operators (eg. `filter`, `prefix(while:)` or `drop(while:)`).

## API


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

## Examples

A simple predicate

```swift
users.filter(\.age > 30)
```

or join predicates together to create more complex filters

```swift
users.filter(\.isClearToFly == false && \.age > 60)
```

or check all objects satisfy a predicate requirement.

```swift
users.allSatisfy(\.age > 20)
```

See more examples in the unit tests.

# Installation

## SwiftPM:

```swift
package.append(.package(url: "https://github.com/ollieatkinson/Predicate.swift", from: "0.1.0"))
```
