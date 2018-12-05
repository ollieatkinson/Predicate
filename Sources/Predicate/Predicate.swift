internal typealias LogicalComparison<Value> = (Value, Value) -> Bool

public struct Predicate<Object> {
    
    private let evaluateBlock: EvaluateBlock
    
    internal init(value: Bool) {
        self.evaluateBlock = { _ in value }
    }
    
    internal init(value: @escaping () -> Bool) {
        self.evaluateBlock = { _ in value() }
    }
    
    internal init<Value>(keyPath: KeyPath<Object, Value>, value: Value, _ logicalComparison: @escaping LogicalComparison<Value>) {
        self.evaluateBlock = { object in logicalComparison(object[keyPath: keyPath], value) }
    }
    
    public func evaluate(with object: Object) -> Bool {
        return evaluateBlock(object)
    }
    
}

extension Predicate: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self.init(value: value)
    }
    
}

extension Predicate {
    
    internal typealias EvaluateBlock = (_ object: Object) -> Bool
    
    internal init(evaluate: @escaping EvaluateBlock) {
        self.evaluateBlock = evaluate
    }
    
}

extension Predicate {
    
    public var not: Predicate {
        return Predicate(evaluate: { object in !self.evaluate(with: object) })
    }
    
}

public typealias CompoundPredicate<Object> = Predicate<Object>

extension CompoundPredicate {
    
    public func and(_ other: Predicate<Object>) -> Predicate<Object> {
        return CompoundPredicate(evaluate: { self.evaluate(with: $0) && other.evaluate(with: $0) })
    }
    
    public func or(_ other: Predicate<Object>) -> Predicate<Object> {
        return CompoundPredicate(evaluate: { self.evaluate(with: $0) || other.evaluate(with: $0) })
    }
    
}
