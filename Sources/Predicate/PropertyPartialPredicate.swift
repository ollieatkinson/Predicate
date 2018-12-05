public struct PropertyPartialPredicate<Object, Value> {
    let keyPath: KeyPath<Object, Value>
}

extension PropertyPartialPredicate where Value: Equatable {
    
    func equal(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, ==)
    }
    
    func notEqual(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, ==)
    }
    
}

extension PropertyPartialPredicate where Value: Comparable {
    
    func lessThan(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, <)
    }
    
    func moreThan(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, >)
    }
    
    func lessThanOrEqualTo(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, <=)
    }
    
    func moreThanOrEqualTo(value: Value) -> Predicate<Object> {
        return Predicate(keyPath: keyPath, value: value, >=)
    }
    
}
