//
//  SimplePresenter.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 30.11.2021.
//

import Foundation
import Combine

final class ViewState: ObservableObject {
	@Published var text: String = ""
	@Published var city: Result<City?, Error>?
}

final class SimplePresenter {
	private let interactor: SimpleInteractorProtocol
	private let viewState: ViewState
	private let scheduler: AnySchedulerOf<RunLoop>
	
	private var subscriptions = Set<AnyCancellable>()
	
	init(
		interactor: SimpleInteractorProtocol,
		viewState: ViewState,
		scheduler: AnySchedulerOf<RunLoop> = .main
	) {
		self.interactor = interactor
		self.viewState = viewState
		self.scheduler = scheduler
		
		setupObservers()
	}
	
	private func setupObservers() {
		viewState
			.$text
			.dropFirst()
			.debounce(for: .microseconds(300), scheduler: scheduler)
			.flatMap { [interactor] in
				interactor.findCity(by: $0)
			}
			.sink(receiveCompletion: {_ in  }, receiveValue: { _ in })
			.store(in: &subscriptions)
	}
}

extension SimplePresenter: SimpleViewOutput {
	func update(text: String) {
		viewState.text = text
	}
	
	func findCity(by name: String) {
		interactor.findCity(by: name)
			.receive(on: scheduler)
			.sink(
				receiveCompletion: { [viewState] result in
					switch result {
					case .finished:
						break
					case let .failure(error):
						viewState.city = .failure(error)
					}
				},
				receiveValue: { [viewState] in
					viewState.city = .success($0)
				}
			)
			.store(in: &subscriptions)
	}
}
