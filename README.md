# Predicate.swift

[![Build Status](https://travis-ci.com/ollieatkinson/Predicate.swift.svg?branch=master)](https://travis-ci.com/ollieatkinson/Predicate.swift) 
[![Swift 4.2](https://img.shields.io/badge/swift-4.2-ED523F.svg?style=flat)](https://swift.org/download/) 
[![SPM](https://img.shields.io/badge/swift-SPM-ED523F.svg?style=flat)](https://swift.org/package-manager/)
![SPM](https://img.shields.io/badge/os-linux-lightgrey.svg?style=flat)
![macOS](https://img.shields.io/badge/os-macOS-lightgrey.svg?style=flat)
[![Licence](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat)](LICENCE)

Predicate composition for filtering operators (eg. `filter`, `prefix(while:)` or `drop(while:)`).

```swift
users.filter(\.age > 30)
```

# Installation

## SwiftPM:

```swift
package.append(.package(url: "https://github.com/ollieatkinson/Predicate.swift", from: "0.1.0"))
```
