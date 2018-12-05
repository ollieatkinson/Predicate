public typealias LogicalComparison<Value> = (Value, Value) -> Bool

public struct Predicate<Object> {
    
    private let evaluateBlock: EvaluateBlock
    
    public init(value: Bool) {
        self.evaluateBlock = { _, _ in value }
    }
    
    public init(value: @escaping () -> Bool) {
        self.evaluateBlock = { _, _ in value() }
    }
    
    public init<Value>(keyPath: KeyPath<Object, Value>, value: Value, _ logicalComparison: @escaping LogicalComparison<Value>) {
        self.evaluateBlock = { _, object in logicalComparison(object[keyPath: keyPath], value) }
    }
    
    public func evaluate(with object: Object) -> Bool {
        return evaluateBlock(self, object)
    }
    
}

extension Predicate: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self.init(value: value)
    }
    
}

extension Predicate {
    
    private typealias EvaluateBlock = (_ instance: Predicate<Object>, _ object: Object) -> Bool
    
    private init(evaluate: @escaping EvaluateBlock) {
        self.evaluateBlock = evaluate
    }
    
}

extension Predicate {
    
    public var not: Predicate {
        return Predicate(evaluate: { original, object in !original.evaluate(with: object) })
    }
    
}

public typealias CompoundPredicate<Object> = Predicate<Object>

extension CompoundPredicate {
    
    public func and(_ other: Predicate<Object>) -> Predicate<Object> {
        return CompoundPredicate(evaluate: { $0.evaluate(with: $1) && other.evaluate(with: $1) })
    }
    
    public func or(_ other: Predicate<Object>) -> Predicate<Object> {
        return CompoundPredicate(evaluate: { $0.evaluate(with: $1) || other.evaluate(with: $1) })
    }
    
}
