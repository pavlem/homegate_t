//
//  HomeItemResponse.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 10.5.21..
//

import Foundation

struct HomeItemResponse: Decodable {
    let advertisementId: Int
    let title: String
    let pictures: [String]
    let city: String
    let country: String
    let offerType: String
    let objectCategory: String
    let description: String
    let street: String
    let priceUnit: String
    let price: Int?
    let currency: String
}
