//

import Combine
import Foundation

public struct AnyScheduler<SchedulerTimeType, SchedulerOptions>: Scheduler
    where
    SchedulerTimeType: Strideable,
    SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible
{
    private let _minimumTolerance: () -> SchedulerTimeType.Stride
    private let _now: () -> SchedulerTimeType
    private let _scheduleAfterIntervalToleranceOptionsAction:
        (
            SchedulerTimeType,
            SchedulerTimeType.Stride,
            SchedulerTimeType.Stride,
            SchedulerOptions?,
            @escaping () -> Void
        ) -> Cancellable
    private let _scheduleAfterToleranceOptionsAction:
        (
            SchedulerTimeType,
            SchedulerTimeType.Stride,
            SchedulerOptions?,
            @escaping () -> Void
        ) -> Void
    private let _scheduleOptionsAction: (SchedulerOptions?, @escaping () -> Void) -> Void

    /// The minimum tolerance allowed by the scheduler.
    public var minimumTolerance: SchedulerTimeType.Stride { _minimumTolerance() }

    /// This scheduler’s definition of the current moment in time.
    public var now: SchedulerTimeType { _now() }

    /// Creates a type-erasing scheduler to wrap the provided scheduler.
    ///
    /// - Parameters:
    ///   - scheduler: A scheduler to wrap with a type-eraser.
    public init<S: Scheduler>(_ scheduler: S) where S.SchedulerTimeType == SchedulerTimeType, S.SchedulerOptions == SchedulerOptions {
        _now = { scheduler.now }
        _minimumTolerance = { scheduler.minimumTolerance }
        _scheduleAfterToleranceOptionsAction = scheduler.schedule
        _scheduleAfterIntervalToleranceOptionsAction = scheduler.schedule
        _scheduleOptionsAction = scheduler.schedule
    }

    /// Performs the action at some time after the specified date.
    public func schedule(
        after date: SchedulerTimeType,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        _scheduleAfterToleranceOptionsAction(date, tolerance, options, action)
    }

    /// Performs the action at some time after the specified date, at the
    /// specified frequency, taking into account tolerance if possible.
    public func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        _scheduleAfterIntervalToleranceOptionsAction(
            date, interval, tolerance, options, action
        )
    }

    /// Performs the action at the next possible opportunity.
    public func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
        _scheduleOptionsAction(options, action)
    }
}

/// A convenience type to specify an `AnyScheduler` by the scheduler it wraps rather than by the
/// time type and options type.
public typealias AnySchedulerOf<Scheduler: Combine.Scheduler> = AnyScheduler<Scheduler.SchedulerTimeType, Scheduler.SchedulerOptions>

public extension Scheduler {
    /// Wraps this scheduler with a type eraser.
    func eraseToAnyScheduler() -> AnyScheduler<SchedulerTimeType, SchedulerOptions> {
        AnyScheduler(self)
    }
}

public extension AnyScheduler where SchedulerTimeType == DispatchQueue.SchedulerTimeType, SchedulerOptions == DispatchQueue.SchedulerOptions {
    /// A type-erased main dispatch queue.
    static var main: Self {
        DispatchQueue.main.eraseToAnyScheduler()
    }
}

public extension AnyScheduler where SchedulerTimeType == OperationQueue.SchedulerTimeType, SchedulerOptions == OperationQueue.SchedulerOptions {
    /// A type-erased main operation queue.
    static var main: Self {
        OperationQueue.main.eraseToAnyScheduler()
    }
}

public extension AnyScheduler where SchedulerTimeType == RunLoop.SchedulerTimeType, SchedulerOptions == RunLoop.SchedulerOptions {
    /// A type-erased main run loop.
    static var main: Self {
        RunLoop.main.eraseToAnyScheduler()
    }
}
