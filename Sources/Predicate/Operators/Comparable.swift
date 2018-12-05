// MARK:- lessThan

public func < <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).lessThan(value: value)
}

public func <= <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).lessThanOrEqualTo(value: value)
}

// MARK:- moreThan

public func > <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).moreThan(value: value)
}

public func >= <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).moreThanOrEqualTo(value: value)
}
