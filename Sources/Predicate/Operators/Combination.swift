// MARK:- and

public func && <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return lhs.and(rhs)
}

public func && <T>(lhs: Predicate<T>, rhs: @escaping @autoclosure () -> Bool) -> CompoundPredicate<T> {
    return lhs.and(Predicate(value: rhs))
}

public func && <T>(lhs: @escaping @autoclosure () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return Predicate(value: lhs).and(rhs)
}

// MARK:- or

public func || <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return lhs.or(rhs)
}

public func || <T>(lhs: Predicate<T>, rhs: @escaping @autoclosure () -> Bool) -> CompoundPredicate<T> {
    return lhs.or(Predicate(value: rhs))
}

public func || <T>(lhs: @escaping @autoclosure () -> Bool, rhs: Predicate<T>) -> CompoundPredicate<T> {
    return Predicate(value: lhs).or(rhs)
}

// MARK:- not

public prefix func ! <T>(predicate: Predicate<T>) -> Predicate<T> {
    return predicate.not
}
