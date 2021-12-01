//
//  SimpleInteractor.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 30.11.2021.
//

import Combine
import Foundation

final class SimpleInteractor {
	private let queue: DispatchQueue
	private let cityService: CityServiceProtocol
	private var subscrptions = Set<AnyCancellable>()
	
	private var cities: [City] = []
	
	init(queue: DispatchQueue, cityService: CityServiceProtocol) {
		self.queue = queue
		self.cityService = cityService
	}
}

extension SimpleInteractor: SimpleInteractorProtocol {
	func getCities() -> [City] {
		return cities
	}
	
	func loadCities() -> AnyPublisher<[City], Error> {
		cityService.getCities()
	}
	
	func save(cities: [City], mainQueueCompletion: @escaping () -> Void) {
		let validCities = cities.filter { !$0.isVisited }
		
		cityService
			.save(cities: validCities)
			.receive(on: queue)
			.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
				DispatchQueue.main.async {
					self?.cities = cities
					mainQueueCompletion()
				}
			})
			.store(in: &subscrptions)
	}
	
	func save(cities: [City], bgQueueCompletion:  @escaping () -> Void) {
		let validCities = cities.filter { !$0.isVisited }
		
		cityService
			.save(cities: validCities)
			.receive(on: queue)
			.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
				self?.cities = cities
				bgQueueCompletion()
			})
			.store(in: &subscrptions)
	}
	
	func findCity(by name: String) -> AnyPublisher<City?, Error> {
		Result.Publisher(nil).eraseToAnyPublisher()
	}
}
