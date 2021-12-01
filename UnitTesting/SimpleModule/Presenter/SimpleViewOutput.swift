//
//  SimplePresenterProtocol.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 30.11.2021.
//

protocol SimpleViewOutput: AnyObject {
	func update(text: String)
	func findCity(by name: String)
}
