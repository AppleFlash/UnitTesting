//
//  SimplePresenterTests.swift
//  UnitTestingTests
//
//  Created by Vladislav Sedinkin on 02.12.2021.
//

@testable import UnitTesting

import XCTest
import Combine

final class SimplePresenterTests: XCTestCase {
	private var presenter: SimpleViewOutput!
	private var viewState: ViewState!
	private var interactor: SimpleInteractorProtocolMock!
	
	private var subscription: AnyCancellable?

	override func setUp() {
		super.setUp()
		
		interactor = SimpleInteractorProtocolMock()
		viewState = ViewState()
	}

	override func tearDown() {
		presenter = nil
		viewState = nil
		interactor = nil
		subscription = nil
		
		super.tearDown()
	}
	
	private func setupPresenter(with scheduler: AnySchedulerOf<RunLoop>) {
		presenter = SimplePresenter(interactor: interactor, viewState: viewState, scheduler: scheduler)
	}

	// MARK: Демонстрация TestScheduler
	
	/**
	 Тест проверяет обработку введённого текста. Но текст обрабатывается с задержкой с 300 миллисекунд.
	 Благодаря TestScheduler мы можем "пропустить" эти 300 мс и выполнить тест синхронно и почти мгновенно
	 */
	func test_updateText_withTestScheduler_version1() {
		// given
		let scheduler = RunLoop.test
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let searchText = "test"
		interactor.given(.findCity(by: .value(searchText), willReturn: Result.Publisher(nil).eraseToAnyPublisher()))
		
		// when
		presenter.update(text: searchText)
		scheduler.run()
		
		// then
		interactor.verify(.findCity(by: .value(searchText)), count: 1)
	}
	
	// Суть таже что и у первой версии подобного теста, но расписан более подробно, с фактическим сдвигом по 100 мс
	func test_updateText_withTestScheduler_version2() {
		// given
		let scheduler = RunLoop.test
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let searchText = "test"
		interactor.given(.findCity(by: .value(searchText), willReturn: Result.Publisher(nil).eraseToAnyPublisher()))
		
		// when
		presenter.update(text: searchText)
		
		// then
		scheduler.advance(by: .microseconds(100))
		interactor.verify(.findCity(by: .value(searchText)), count: 0)
		scheduler.advance(by: .microseconds(100))
		interactor.verify(.findCity(by: .value(searchText)), count: 0)
		scheduler.advance(by: .microseconds(100))
		interactor.verify(.findCity(by: .value(searchText)), count: 1)
	}
	
	// Тест всегда падает!
	// Тест проверяет тот же сценарий, что и 1 и 2 версия подобного теста, но использует ImmediateScheduler.
	// Показана ситуация в которой нельзя применить ImmediateScheduler
	func test_updateText_withTestScheduler_version3_NOT_WORK() {
		// given
		let scheduler = RunLoop.immediate
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let searchText = "test"
		interactor.given(.findCity(by: .value(searchText), willReturn: Result.Publisher(nil).eraseToAnyPublisher()))
		
		// when
		presenter.update(text: searchText)
		
		// then
		interactor.verify(.findCity(by: .value(searchText)), count: 1)
	}
	
	// MARK: Демонстрация ImmediateScheduler
	
	// Тест проверяет поиск города по названию. Реализация также использует Combine, + использует функцию .receive(on:),
	// чтобы результат обрабатывался на определенном потоке. Но из-за этого код выполняется асинхронно.
	// Решение - использовать ImmediateScheduler. С ним тест можно выполнить синхронно
	func test_findCity_withImmediateScheduer() {
		// given
		continueAfterFailure = false
		let scheduler = RunLoop.immediate
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let name = "test"
		let city = City()
		interactor.given(.findCity(by: .value(name), willReturn: Result.Publisher(city).eraseToAnyPublisher()))
		
		// when
		XCTAssertNil(viewState.city)
		presenter.findCity(by: name)
		
		// then
		XCTAssertNotNil(viewState.city)
		XCTAssertEqual(try viewState.city!.get(), city)
	}
	
	// Тест всегда падает!
	// Тот же пример, что и в тесте выше, но с использованием RunLoop.main. Тест асинхронный, в синхронном режиме падаем
	func test_findCity_withRunLoopMainScheduler_NOT_WORK() {
		// given
		let scheduler = RunLoop.main
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let name = "test"
		let city = City()
		interactor.given(.findCity(by: .value(name), willReturn: Result.Publisher(city).eraseToAnyPublisher()))
		
		// when
		XCTAssertNil(viewState.city)
		presenter.findCity(by: name)
		
		// then
		XCTAssertNotNil(viewState.city)
	}
	
	// Без использования scheduler приходилось бы писать подобные конструкции
	func test_findCity_withRunLoopMainScheduler_expectation() {
		// given
		continueAfterFailure = false
		let scheduler = RunLoop.main
		setupPresenter(with: scheduler.eraseToAnyScheduler())
		let name = "test"
		let city = City()
		interactor.given(.findCity(by: .value(name), willReturn: Result.Publisher(city).eraseToAnyPublisher()))
		
		var receivedCity: Result<City?, Error>?
		
		// when
		waitAsyncAction { fulfill in
			subscription = viewState
				.$city
				.dropFirst()
				.sink(receiveCompletion: { _ in }, receiveValue: {
					receivedCity = $0
					fulfill()
				})
			
			XCTAssertNil(viewState.city)
			presenter.findCity(by: name)
		}
		
		// then
		XCTAssertNotNil(receivedCity)
		XCTAssertEqual(try viewState.city!.get(), city)
	}
}
