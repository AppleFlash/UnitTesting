//
//  BackgroundTestable.swift
//  UnitTestingTests
//
//  Created by Vladislav Sedinkin on 01.12.2021.
//

import Foundation

protocol BackgroundTestable {
	var backgroundQueue: DispatchQueue { get }
}

extension BackgroundTestable {
	func waitForBackgroundOperations() {
		// Wait for all background operations placed before
		backgroundQueue.sync {}
	}
}
