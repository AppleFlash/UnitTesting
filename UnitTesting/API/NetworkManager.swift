//
//  NetworkManager.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 01.12.2021.
//

import Foundation
import Combine

// MARK: - Interface

enum NetworkError: Error {
	case smthgWentWrong
}

protocol NetworkManagerProtocol: AnyObject, AutoMockable {
	func performFakeRequest(delay: TimeInterval) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class NetworkManager: NetworkManagerProtocol {
	private let queue = DispatchQueue(label: "com.network.manager.queue")
	
	func performFakeRequest(delay: TimeInterval) -> AnyPublisher<Void, Error> {
		Deferred { [queue] in
			Future { promise in
				queue.asyncAfter(deadline: .now() + delay) {
					promise(.success(()))
				}
			}
		}
		.eraseToAnyPublisher()
	}
}
