//
//  SimpleModuleInteractorTests.swift
//  UnitTestingTests
//
//  Created by Vladislav Sedinkin on 01.12.2021.
//

@testable import UnitTesting

import Foundation
import Combine
import XCTest

class SimpleModuleInteractorTests: XCTestCase, BackgroundTestable {
	private var interactor: SimpleInteractorProtocol!
	private var cityService: CityServiceProtocolMock!
	
	let backgroundQueue = DispatchQueue(label: "com.interactor.tests.queue")

    override func setUp() {
        super.setUp()
		
		cityService = CityServiceProtocolMock()
		interactor = SimpleInteractor(queue: backgroundQueue, cityService: cityService)
    }

    override func tearDown() {
		interactor = nil
		cityService = nil
		
        super.tearDown()
    }

	// Тест всегда падает!
	// Потому что замыкание, которое сообщает о завершении операции сохраненя вызывается не на backgroundQueue
	// Главный поток заблокирован до тех пор, пока есть задачи на backgroundQueue, как только задачи кончаются происходит разблокировка
	// главного потока и выполнение теста продолжается. Замыкание завершения же выполняется асинхронно на главном потоке чуть позже
	func test_saveCities_mainQueueCompletion_failure() {
		// given
		let cities = [City(name: "1", isVisited: false), City(name: "2", isVisited: false)]
		
		cityService.given(
			.save(cities: .value(cities), willReturn: Result.Publisher(()).eraseToAnyPublisher())
		)
		
		// when
		interactor.save(
			cities: cities,
			mainQueueCompletion: { print("\(#function) - Work is done!") }
		)
		waitForBackgroundOperations()
		
		// then
		print("\(#function) - Ready to check")
		let saved = interactor.getCities()
		XCTAssertEqual(saved, cities)
		
		/**
		 В консоле увидим
		 Ready to check
		 Work is done!
		 */
	}
	
	// Тут проблемы с замыканием нет, т.к. используется станартный подход с expectation
	func test_saveCities_mainQueueCompletion_success() {
		// given
		let cities = [City(name: "1", isVisited: false), City(name: "2", isVisited: false)]
		
		cityService.given(
			.save(cities: .value(cities), willReturn: Result.Publisher(()).eraseToAnyPublisher())
		)
		
		// when
		// Ждем завершения работы через expectation
		waitAsyncAction { fulfill in
			interactor.save(cities: cities, mainQueueCompletion: fulfill)
		}
		
		// then
		let saved = interactor.getCities()
		XCTAssertEqual(saved, cities)
	}
	
	// Тест проходит корректно, т.к. замыкание завершения вызывается на backgroundQueue и главный поток разблокируется вовремя
	func test_saveCities_bgQueueCompletion() {
		// given
		let cities = [City(name: "1", isVisited: false), City(name: "2", isVisited: false)]
		
		cityService.given(
			.save(cities: .value(cities), willReturn: Result.Publisher(()).eraseToAnyPublisher())
		)
		
		// when
		interactor.save(
			cities: cities,
			bgQueueCompletion: { print("\(#function) - Work is done!") }
		)
		waitForBackgroundOperations()
		
		// then
		print("\(#function) - Ready to check")
		let saved = interactor.getCities()
		XCTAssertEqual(saved, cities)
		
		/**
		 В консоле увидим
		 Work is done!
		 Ready to check
		 */
	}
	
	// Тест проверяет, что в вход в сервис для сохранения поступят только города, у которых флаг isVisited == false.
	// Это проверяется через функцию verify
	func test_saveCities_onlyNotVisitedCities() {
		// given
		let cities = [City(name: "1", isVisited: false), City(name: "2", isVisited: true)]
		let onlyNotVisitedCities = cities.filter { !$0.isVisited }
		
		// Намеренно не ставим ограничение для задания стаба на возвращаемое значение
		// (не указываем для какого списка городов должно вернуться значение)
		cityService.given(
			.save(cities: .any, willReturn: Result.Publisher(()).eraseToAnyPublisher())
		)
		
		// when
		interactor.save(cities: cities, bgQueueCompletion: {})
		waitForBackgroundOperations()
		
		// then
		cityService.verify(.save(cities: .value(onlyNotVisitedCities)), count: 1)
	}
}
