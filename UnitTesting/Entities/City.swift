//
//  City.swift
//  UnitTesting
//
//  Created by Vladislav Sedinkin on 30.11.2021.
//

import Foundation

struct City: Equatable {
	let name: String
	let latitude: Double
	let longitude: Double
	let isVisited: Bool
	
	init(
		name: String = UUID().uuidString,
		latitude: Double = .random(in: 100...200),
		longitude: Double = .random(in: 201...300),
		isVisited: Bool = .random()
	) {
		self.name = name
		self.latitude = latitude
		self.longitude = longitude
		self.isVisited = isVisited
	}
}
