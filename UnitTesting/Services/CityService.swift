//
//  CityService.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 01.12.2021.
//

import Combine
import Foundation

// MARK: - Interface

protocol CityServiceProtocol: AnyObject, AutoMockable {
	func getCities() -> AnyPublisher<[City], Error>
	func getCity(name: String) -> AnyPublisher<City?, Error>
	func save(cities: [City]) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class CityService {
	private let networkManager: NetworkManagerProtocol
	
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
}

extension CityService: CityServiceProtocol {
	func getCities() -> AnyPublisher<[City], Error> {
		networkManager
			.performFakeRequest(delay: 2)
			.map {
				(0..<Int.random(in: 2..<10)).map { _ in City() }
			}
			.eraseToAnyPublisher()
	}
	
	func getCity(name: String) -> AnyPublisher<City?, Error> {
		networkManager
			.performFakeRequest(delay: 2)
			.map { City() }
			.eraseToAnyPublisher()
	}
	
	func save(cities: [City]) -> AnyPublisher<Void, Error> {
		networkManager.performFakeRequest(delay: 2)
	}
}
