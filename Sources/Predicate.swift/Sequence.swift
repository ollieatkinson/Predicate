extension Sequence {
    
    public func filter(_ predicate: Predicate<Element>) -> [Element] {
        return filter(predicate.evaluate)
    }
    
}
