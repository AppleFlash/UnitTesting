// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0

//swiftlint:disable all

import SwiftyMocky
import XCTest
import Combine
@testable import UnitTesting


// MARK: - CityServiceProtocol

open class CityServiceProtocolMock: CityServiceProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCities() -> AnyPublisher<[City], Error> {
        addInvocation(.m_getCities)
		let perform = methodPerformValue(.m_getCities) as? () -> Void
		perform?()
		var __value: AnyPublisher<[City], Error>
		do {
		    __value = try methodReturnValue(.m_getCities).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getCities(). Use given")
			Failure("Stub return value not specified for getCities(). Use given")
		}
		return __value
    }

    open func getCity(name: String) -> AnyPublisher<City?, Error> {
        addInvocation(.m_getCity__name_name(Parameter<String>.value(`name`)))
		let perform = methodPerformValue(.m_getCity__name_name(Parameter<String>.value(`name`))) as? (String) -> Void
		perform?(`name`)
		var __value: AnyPublisher<City?, Error>
		do {
		    __value = try methodReturnValue(.m_getCity__name_name(Parameter<String>.value(`name`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getCity(name: String). Use given")
			Failure("Stub return value not specified for getCity(name: String). Use given")
		}
		return __value
    }

    open func save(cities: [City]) -> AnyPublisher<Void, Error> {
        addInvocation(.m_save__cities_cities(Parameter<[City]>.value(`cities`)))
		let perform = methodPerformValue(.m_save__cities_cities(Parameter<[City]>.value(`cities`))) as? ([City]) -> Void
		perform?(`cities`)
		var __value: AnyPublisher<Void, Error>
		do {
		    __value = try methodReturnValue(.m_save__cities_cities(Parameter<[City]>.value(`cities`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for save(cities: [City]). Use given")
			Failure("Stub return value not specified for save(cities: [City]). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getCities
        case m_getCity__name_name(Parameter<String>)
        case m_save__cities_cities(Parameter<[City]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCities, .m_getCities): return .match

            case (.m_getCity__name_name(let lhsName), .m_getCity__name_name(let rhsName)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "name"))
				return Matcher.ComparisonResult(results)

            case (.m_save__cities_cities(let lhsCities), .m_save__cities_cities(let rhsCities)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCities, rhs: rhsCities, with: matcher), lhsCities, rhsCities, "cities"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getCities: return 0
            case let .m_getCity__name_name(p0): return p0.intValue
            case let .m_save__cities_cities(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCities: return ".getCities()"
            case .m_getCity__name_name: return ".getCity(name:)"
            case .m_save__cities_cities: return ".save(cities:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getCities(willReturn: AnyPublisher<[City], Error>...) -> MethodStub {
            return Given(method: .m_getCities, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCity(name: Parameter<String>, willReturn: AnyPublisher<City?, Error>...) -> MethodStub {
            return Given(method: .m_getCity__name_name(`name`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func save(cities: Parameter<[City]>, willReturn: AnyPublisher<Void, Error>...) -> MethodStub {
            return Given(method: .m_save__cities_cities(`cities`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCities(willProduce: (Stubber<AnyPublisher<[City], Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[City], Error>] = []
			let given: Given = { return Given(method: .m_getCities, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[City], Error>).self)
			willProduce(stubber)
			return given
        }
        public static func getCity(name: Parameter<String>, willProduce: (Stubber<AnyPublisher<City?, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<City?, Error>] = []
			let given: Given = { return Given(method: .m_getCity__name_name(`name`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<City?, Error>).self)
			willProduce(stubber)
			return given
        }
        public static func save(cities: Parameter<[City]>, willProduce: (Stubber<AnyPublisher<Void, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Error>] = []
			let given: Given = { return Given(method: .m_save__cities_cities(`cities`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCities() -> Verify { return Verify(method: .m_getCities)}
        public static func getCity(name: Parameter<String>) -> Verify { return Verify(method: .m_getCity__name_name(`name`))}
        public static func save(cities: Parameter<[City]>) -> Verify { return Verify(method: .m_save__cities_cities(`cities`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCities(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getCities, performs: perform)
        }
        public static func getCity(name: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getCity__name_name(`name`), performs: perform)
        }
        public static func save(cities: Parameter<[City]>, perform: @escaping ([City]) -> Void) -> Perform {
            return Perform(method: .m_save__cities_cities(`cities`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - NetworkManagerProtocol

open class NetworkManagerProtocolMock: NetworkManagerProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func performFakeRequest(delay: TimeInterval) -> AnyPublisher<Void, Error> {
        addInvocation(.m_performFakeRequest__delay_delay(Parameter<TimeInterval>.value(`delay`)))
		let perform = methodPerformValue(.m_performFakeRequest__delay_delay(Parameter<TimeInterval>.value(`delay`))) as? (TimeInterval) -> Void
		perform?(`delay`)
		var __value: AnyPublisher<Void, Error>
		do {
		    __value = try methodReturnValue(.m_performFakeRequest__delay_delay(Parameter<TimeInterval>.value(`delay`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for performFakeRequest(delay: TimeInterval). Use given")
			Failure("Stub return value not specified for performFakeRequest(delay: TimeInterval). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_performFakeRequest__delay_delay(Parameter<TimeInterval>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_performFakeRequest__delay_delay(let lhsDelay), .m_performFakeRequest__delay_delay(let rhsDelay)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelay, rhs: rhsDelay, with: matcher), lhsDelay, rhsDelay, "delay"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_performFakeRequest__delay_delay(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_performFakeRequest__delay_delay: return ".performFakeRequest(delay:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func performFakeRequest(delay: Parameter<TimeInterval>, willReturn: AnyPublisher<Void, Error>...) -> MethodStub {
            return Given(method: .m_performFakeRequest__delay_delay(`delay`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func performFakeRequest(delay: Parameter<TimeInterval>, willProduce: (Stubber<AnyPublisher<Void, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Error>] = []
			let given: Given = { return Given(method: .m_performFakeRequest__delay_delay(`delay`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func performFakeRequest(delay: Parameter<TimeInterval>) -> Verify { return Verify(method: .m_performFakeRequest__delay_delay(`delay`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func performFakeRequest(delay: Parameter<TimeInterval>, perform: @escaping (TimeInterval) -> Void) -> Perform {
            return Perform(method: .m_performFakeRequest__delay_delay(`delay`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SimpleInteractorProtocol

open class SimpleInteractorProtocolMock: SimpleInteractorProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCities() -> [City] {
        addInvocation(.m_getCities)
		let perform = methodPerformValue(.m_getCities) as? () -> Void
		perform?()
		var __value: [City]
		do {
		    __value = try methodReturnValue(.m_getCities).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getCities(). Use given")
			Failure("Stub return value not specified for getCities(). Use given")
		}
		return __value
    }

    open func loadCities() -> AnyPublisher<[City], Error> {
        addInvocation(.m_loadCities)
		let perform = methodPerformValue(.m_loadCities) as? () -> Void
		perform?()
		var __value: AnyPublisher<[City], Error>
		do {
		    __value = try methodReturnValue(.m_loadCities).casted()
		} catch {
			onFatalFailure("Stub return value not specified for loadCities(). Use given")
			Failure("Stub return value not specified for loadCities(). Use given")
		}
		return __value
    }

    open func save(cities: [City], mainQueueCompletion: @escaping () -> Void) {
        addInvocation(.m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(Parameter<[City]>.value(`cities`), Parameter<() -> Void>.value(`mainQueueCompletion`)))
		let perform = methodPerformValue(.m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(Parameter<[City]>.value(`cities`), Parameter<() -> Void>.value(`mainQueueCompletion`))) as? ([City], @escaping () -> Void) -> Void
		perform?(`cities`, `mainQueueCompletion`)
    }

    open func save(cities: [City], bgQueueCompletion: @escaping () -> Void) {
        addInvocation(.m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(Parameter<[City]>.value(`cities`), Parameter<() -> Void>.value(`bgQueueCompletion`)))
		let perform = methodPerformValue(.m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(Parameter<[City]>.value(`cities`), Parameter<() -> Void>.value(`bgQueueCompletion`))) as? ([City], @escaping () -> Void) -> Void
		perform?(`cities`, `bgQueueCompletion`)
    }

    open func findCity(by name: String) -> AnyPublisher<City?, Error> {
        addInvocation(.m_findCity__by_name(Parameter<String>.value(`name`)))
		let perform = methodPerformValue(.m_findCity__by_name(Parameter<String>.value(`name`))) as? (String) -> Void
		perform?(`name`)
		var __value: AnyPublisher<City?, Error>
		do {
		    __value = try methodReturnValue(.m_findCity__by_name(Parameter<String>.value(`name`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for findCity(by name: String). Use given")
			Failure("Stub return value not specified for findCity(by name: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getCities
        case m_loadCities
        case m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(Parameter<[City]>, Parameter<() -> Void>)
        case m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(Parameter<[City]>, Parameter<() -> Void>)
        case m_findCity__by_name(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCities, .m_getCities): return .match

            case (.m_loadCities, .m_loadCities): return .match

            case (.m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(let lhsCities, let lhsMainqueuecompletion), .m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(let rhsCities, let rhsMainqueuecompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCities, rhs: rhsCities, with: matcher), lhsCities, rhsCities, "cities"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMainqueuecompletion, rhs: rhsMainqueuecompletion, with: matcher), lhsMainqueuecompletion, rhsMainqueuecompletion, "mainQueueCompletion"))
				return Matcher.ComparisonResult(results)

            case (.m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(let lhsCities, let lhsBgqueuecompletion), .m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(let rhsCities, let rhsBgqueuecompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCities, rhs: rhsCities, with: matcher), lhsCities, rhsCities, "cities"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsBgqueuecompletion, rhs: rhsBgqueuecompletion, with: matcher), lhsBgqueuecompletion, rhsBgqueuecompletion, "bgQueueCompletion"))
				return Matcher.ComparisonResult(results)

            case (.m_findCity__by_name(let lhsName), .m_findCity__by_name(let rhsName)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher), lhsName, rhsName, "by name"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getCities: return 0
            case .m_loadCities: return 0
            case let .m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(p0, p1): return p0.intValue + p1.intValue
            case let .m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(p0, p1): return p0.intValue + p1.intValue
            case let .m_findCity__by_name(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCities: return ".getCities()"
            case .m_loadCities: return ".loadCities()"
            case .m_save__cities_citiesmainQueueCompletion_mainQueueCompletion: return ".save(cities:mainQueueCompletion:)"
            case .m_save__cities_citiesbgQueueCompletion_bgQueueCompletion: return ".save(cities:bgQueueCompletion:)"
            case .m_findCity__by_name: return ".findCity(by:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getCities(willReturn: [City]...) -> MethodStub {
            return Given(method: .m_getCities, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func loadCities(willReturn: AnyPublisher<[City], Error>...) -> MethodStub {
            return Given(method: .m_loadCities, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func findCity(by name: Parameter<String>, willReturn: AnyPublisher<City?, Error>...) -> MethodStub {
            return Given(method: .m_findCity__by_name(`name`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCities(willProduce: (Stubber<[City]>) -> Void) -> MethodStub {
            let willReturn: [[City]] = []
			let given: Given = { return Given(method: .m_getCities, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([City]).self)
			willProduce(stubber)
			return given
        }
        public static func loadCities(willProduce: (Stubber<AnyPublisher<[City], Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[City], Error>] = []
			let given: Given = { return Given(method: .m_loadCities, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[City], Error>).self)
			willProduce(stubber)
			return given
        }
        public static func findCity(by name: Parameter<String>, willProduce: (Stubber<AnyPublisher<City?, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<City?, Error>] = []
			let given: Given = { return Given(method: .m_findCity__by_name(`name`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<City?, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCities() -> Verify { return Verify(method: .m_getCities)}
        public static func loadCities() -> Verify { return Verify(method: .m_loadCities)}
        public static func save(cities: Parameter<[City]>, mainQueueCompletion: Parameter<() -> Void>) -> Verify { return Verify(method: .m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(`cities`, `mainQueueCompletion`))}
        public static func save(cities: Parameter<[City]>, bgQueueCompletion: Parameter<() -> Void>) -> Verify { return Verify(method: .m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(`cities`, `bgQueueCompletion`))}
        public static func findCity(by name: Parameter<String>) -> Verify { return Verify(method: .m_findCity__by_name(`name`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCities(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getCities, performs: perform)
        }
        public static func loadCities(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_loadCities, performs: perform)
        }
        public static func save(cities: Parameter<[City]>, mainQueueCompletion: Parameter<() -> Void>, perform: @escaping ([City], @escaping () -> Void) -> Void) -> Perform {
            return Perform(method: .m_save__cities_citiesmainQueueCompletion_mainQueueCompletion(`cities`, `mainQueueCompletion`), performs: perform)
        }
        public static func save(cities: Parameter<[City]>, bgQueueCompletion: Parameter<() -> Void>, perform: @escaping ([City], @escaping () -> Void) -> Void) -> Perform {
            return Perform(method: .m_save__cities_citiesbgQueueCompletion_bgQueueCompletion(`cities`, `bgQueueCompletion`), performs: perform)
        }
        public static func findCity(by name: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_findCity__by_name(`name`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

