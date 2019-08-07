extension Sequence {
    
    public func filter(_ predicate: Predicate<Element>) -> [Element] {
        return filter(predicate.evaluate)
    }
    
    public func prefix(while predicate: Predicate<Element>) -> [Element] {
        return prefix(while: predicate.evaluate)
    }
    
    public func drop(while predicate: Predicate<Element>) -> DropWhileSequence<Self> {
        return drop(while: predicate.evaluate)
    }

    public func first(where predicate: Predicate<Element>) -> Element? {
        return first(where: predicate.evaluate)
    }

    public func contains(where predicate: Predicate<Element>) -> Bool {
        return contains(where: predicate.evaluate)
    }

    public func allSatisfy(_ predicate: Predicate<Element>) -> Bool {
        return allSatisfy(predicate.evaluate)
    }

}
