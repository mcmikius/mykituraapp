//
//  Book.swift
//  Application
//
//  Created by Michail Bondarenko on 3/19/19.
//

import Foundation

struct Book: Codable {
    let id: Int
    let title: String
    let price: Double
    let genre: String
}
