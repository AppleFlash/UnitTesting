//
//  XCTestCase+.swift
//  UnitTestingTests
//
//  Created by Vladislav Sedinkin on 01.12.2021.
//

import XCTest

public extension XCTestCase {
	func waitAsyncAction<T>(
		_ name: String = #function,
		timeout: TimeInterval = 1,
		action: (@escaping () -> Void) throws -> T
	) rethrows -> T {
		let expectation = expectation(description: name)
		let result = try action(expectation.fulfill)

		waitForExpectations(timeout: timeout)

		return result
	}
}
