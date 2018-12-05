public func == <Root, Value: Equatable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return PropertyPartialPredicate(keyPath: keyPath).equal(value: value)
}

public func != <Root, Value: Equatable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return Predicate(keyPath: keyPath, value: value, !=)
}

public func < <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return Predicate(keyPath: keyPath, value: value, <)
}

public func > <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return Predicate(keyPath: keyPath, value: value, >)
}

public func <= <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return Predicate(keyPath: keyPath, value: value, <=)
}

public func >= <Root, Value: Comparable>(keyPath: KeyPath<Root, Value>, value: Value) -> Predicate<Root> {
    return Predicate(keyPath: keyPath, value: value, >=)
}

public func && <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return lhs.and(rhs)
}

public func || <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return lhs.or(rhs)
}

public func && <T>(lhs: Predicate<T>, rhs: @escaping @autoclosure () -> Bool) -> CompoundPredicate<T> {
    return lhs.and(Predicate(value: rhs))
}

public func || <T>(lhs: Predicate<T>, rhs: @escaping @autoclosure () -> Bool) -> CompoundPredicate<T> {
    return lhs.or(Predicate(value: rhs))
}

public func && <T>(lhs: @escaping @autoclosure () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return Predicate(value: lhs).and(rhs)
}

public func || <T>(lhs: @escaping @autoclosure () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return Predicate(value: lhs).or(rhs)
}
