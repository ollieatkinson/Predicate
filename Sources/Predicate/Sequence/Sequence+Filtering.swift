extension Sequence {
    
    public func filter(_ predicate: Predicate<Element>) -> [Element] {
        return filter(predicate.evaluate)
    }
    
    public func prefix(while predicate: Predicate<Element>) -> Self.SubSequence {
        return prefix(while: predicate.evaluate)
    }
    
    public func drop(while predicate: Predicate<Element>) -> Self.SubSequence {
        return drop(while: predicate.evaluate)
    }
    
}
