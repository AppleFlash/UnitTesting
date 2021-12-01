//

import Combine
import Foundation

public struct ImmediateScheduler<SchedulerTimeType, SchedulerOptions>: Scheduler
    where
    SchedulerTimeType: Strideable,
    SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible
{
    public let minimumTolerance: SchedulerTimeType.Stride = .zero
    public let now: SchedulerTimeType

    /// Creates an immediate test scheduler with the given date.
    ///
    /// - Parameter now: The current date of the test scheduler.
    public init(now: SchedulerTimeType) {
        self.now = now
    }

    public func schedule(options _: SchedulerOptions?, _ action: () -> Void) {
        action()
    }

    public func schedule(
        after _: SchedulerTimeType,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: () -> Void
    ) {
        action()
    }

    public func schedule(
        after _: SchedulerTimeType,
        interval _: SchedulerTimeType.Stride,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: () -> Void
    ) -> Cancellable {
        action()
        return AnyCancellable {}
    }
}

public extension DispatchQueue {
    /// An immediate scheduler that can substitute itself for a dispatch queue.
    static var immediate: ImmediateSchedulerOf<DispatchQueue> {
        // NB: `DispatchTime(uptimeNanoseconds: 0) == .now())`. Use `1` for consistency.
        .init(now: SchedulerTimeType(DispatchTime(uptimeNanoseconds: 1)))
    }
}

public extension OperationQueue {
    /// An immediate scheduler that can substitute itself for an operation queue.
    static var immediate: ImmediateSchedulerOf<OperationQueue> {
        .init(now: SchedulerTimeType(Date(timeIntervalSince1970: 0)))
    }
}

public extension RunLoop {
    /// An immediate scheduler that can substitute itself for a run loop.
    static var immediate: ImmediateSchedulerOf<RunLoop> {
        .init(now: SchedulerTimeType(Date(timeIntervalSince1970: 0)))
    }
}

public extension AnyScheduler where SchedulerTimeType == DispatchQueue.SchedulerTimeType, SchedulerOptions == DispatchQueue.SchedulerOptions {
    /// An immediate scheduler that can substitute itself for a dispatch queue.
    static var immediate: Self {
        DispatchQueue.immediate.eraseToAnyScheduler()
    }
}

public extension AnyScheduler where SchedulerTimeType == OperationQueue.SchedulerTimeType, SchedulerOptions == OperationQueue.SchedulerOptions {
    /// An immediate scheduler that can substitute itself for an operation queue.
    static var immediate: Self {
        OperationQueue.immediate.eraseToAnyScheduler()
    }
}

public extension AnyScheduler where SchedulerTimeType == RunLoop.SchedulerTimeType, SchedulerOptions == RunLoop.SchedulerOptions {
    /// An immediate scheduler that can substitute itself for a run loop.
    static var immediate: Self {
        RunLoop.immediate.eraseToAnyScheduler()
    }
}

/// A convenience type to specify an `ImmediateScheduler` by the scheduler it wraps rather than by
/// the time type and options type.

public typealias ImmediateSchedulerOf<Scheduler: Combine.Scheduler> = ImmediateScheduler<Scheduler.SchedulerTimeType, Scheduler.SchedulerOptions>
