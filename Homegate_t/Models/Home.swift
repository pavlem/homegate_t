//
//  Home.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 11.5.21..
//

import Foundation

struct Home: Codable {
    let id: Int
    let price: String
    let title: String
    let address: String
    let imageUrl: String?
    let isFavourite: Bool
    let currency: String
}

extension Home {
    init(homeVM: HomeVM) {
        id = homeVM.id
        price = homeVM.price
        title = homeVM.title
        address = homeVM.address
        imageUrl = homeVM.imageUrl
        isFavourite = homeVM.isFavourite
        currency = homeVM.currency
    }
}
