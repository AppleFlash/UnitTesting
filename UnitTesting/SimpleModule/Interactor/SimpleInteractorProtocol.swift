//
//  SimpleInteractorProtocol.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 30.11.2021.
//

import Combine

protocol SimpleInteractorProtocol: AnyObject, AutoMockable {
	func getCities() -> [City]
	
	func loadCities() -> AnyPublisher<[City], Error>
	func save(cities: [City], mainQueueCompletion: @escaping () -> Void)
	func save(cities: [City], bgQueueCompletion:  @escaping () -> Void)
	
	func findCity(by name: String) -> AnyPublisher<City?, Error>
}
