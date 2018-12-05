// MARK:- equal

public func == <Root, Value: Equatable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).equal(value: value)
}

// MARK:- notEqual

public func != <Root, Value: Equatable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return KeyPathPartialPredicate(keyPath: keyPath).notEqual(value: value)
}
