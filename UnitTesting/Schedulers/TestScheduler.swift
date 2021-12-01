//

import Combine
import Foundation

public final class TestScheduler<SchedulerTimeType, SchedulerOptions>: Scheduler
    where SchedulerTimeType: Strideable, SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible {
    private var lastSequence: UInt = 0
    public let minimumTolerance: SchedulerTimeType.Stride = .zero
    public private(set) var now: SchedulerTimeType
    private var scheduled: [(sequence: UInt, date: SchedulerTimeType, action: () -> Void)] = []

    /// Creates a test scheduler with the given date.
    ///
    /// - Parameter now: The current date of the test scheduler.
    public init(now: SchedulerTimeType) {
        self.now = now
    }

    /// Advances the scheduler by the given stride.
    ///
    /// - Parameter stride: A stride. By default this argument is `.zero`, which does not advance the
    ///   scheduler's time but does cause the scheduler to execute any units of work that are waiting
    ///   to be performed for right now.
    public func advance(by stride: SchedulerTimeType.Stride = .zero) {
        let finalDate = now.advanced(by: stride)

        while now <= finalDate {
            scheduled.sort { ($0.date, $0.sequence) < ($1.date, $1.sequence) }

            guard
                let nextDate = scheduled.first?.date,
                finalDate >= nextDate
            else {
                now = finalDate
                return
            }

            now = nextDate

            while let (_, date, action) = scheduled.first, date == nextDate {
                scheduled.removeFirst()
                action()
            }
        }
    }

    /// Runs the scheduler until it has no scheduled items left.
    ///
    /// This method is useful for proving exhaustively that your publisher eventually completes
    /// and does not run forever. For example, the following code will run an infinite loop forever
    /// because the timer never finishes:
    ///
    ///     let scheduler = DispatchQueue.test
    ///     Publishers.Timer(every: .seconds(1), scheduler: scheduler)
    ///       .autoconnect()
    ///       .sink { _ in print($0) }
    ///       .store(in: &cancellables)
    ///
    ///     scheduler.run() // Will never complete
    ///
    /// If you wanted to make sure that this publisher eventually completes you would need to
    /// chain on another operator that completes it when a certain condition is met. This can be
    /// done in many ways, such as using `prefix`:
    ///
    ///     let scheduler = DispatchQueue.test
    ///     Publishers.Timer(every: .seconds(1), scheduler: scheduler)
    ///       .autoconnect()
    ///       .prefix(3)
    ///       .sink { _ in print($0) }
    ///       .store(in: &cancellables)
    ///
    ///     scheduler.run() // Prints 3 times and completes.
    ///
    public func run() {
        while let date = scheduled.first?.date {
            advance(by: now.distance(to: date))
        }
    }

    public func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        let sequence = nextSequence()

        func scheduleAction(for date: SchedulerTimeType) -> () -> Void {
            return { [weak self] in
                let nextDate = date.advanced(by: interval)
                self?.scheduled.append((sequence, nextDate, scheduleAction(for: nextDate)))
                action()
            }
        }

        scheduled.append((sequence, date, scheduleAction(for: date)))

        return AnyCancellable { [weak self] in
            self?.scheduled.removeAll(where: { $0.sequence == sequence })
        }
    }

    public func schedule(
        after date: SchedulerTimeType,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        scheduled.append((nextSequence(), date, action))
    }

    public func schedule(options _: SchedulerOptions?, _ action: @escaping () -> Void) {
        scheduled.append((nextSequence(), now, action))
    }

    private func nextSequence() -> UInt {
        lastSequence += 1
        return lastSequence
    }
}

public extension DispatchQueue {
    /// A test scheduler of dispatch queues.
    static var test: TestSchedulerOf<DispatchQueue> {
        // NB: `DispatchTime(uptimeNanoseconds: 0) == .now())`. Use `1` for consistency.
        .init(now: .init(.init(uptimeNanoseconds: 1)))
    }
}

public extension OperationQueue {
    /// A test scheduler of operation queues.
    static var test: TestSchedulerOf<OperationQueue> {
        .init(now: .init(.init(timeIntervalSince1970: 0)))
    }
}

public extension RunLoop {
    /// A test scheduler of run loops.
    static var test: TestSchedulerOf<RunLoop> {
        .init(now: .init(.init(timeIntervalSince1970: 0)))
    }
}

/// A convenience type to specify a `TestScheduler` by the scheduler it wraps rather than by the
/// time type and options type.
public typealias TestSchedulerOf<Scheduler> = TestScheduler<
    Scheduler.SchedulerTimeType, Scheduler.SchedulerOptions
> where Scheduler: Combine.Scheduler
