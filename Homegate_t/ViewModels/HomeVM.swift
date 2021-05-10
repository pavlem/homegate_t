//
//  HomeVM.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 10.5.21..
//

import UIKit

struct HomeVM {
    
    // MARK: API
    mutating func fetchImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        dataTask = homesService.fetch(image: imageUrl) { result in
            completion(result)
        }
    }
    
    func cancelImageFetch() {
        dataTask?.cancel()
    }
    
    let id: Int
    let price: String
    let title: String
    let address: String
    let imageUrl: String?
    let currency: String
    
    var isFavourite = false
    
    var priceDescription: String {
        if Int(price) != nil {
            return price + " " + currency
        }
        
        return "NONE"
    }
    
    // MARK: Constants
    let cellHeight = CGFloat(250)
    
    let addressLblFont = UIFont.systemFont(ofSize: 18)
    let titleLblFont = UIFont.boldSystemFont(ofSize: 20)
    let priceLblFont = UIFont.boldSystemFont(ofSize: 20)
    
    let addressLblColor = UIColor.white
    let titleLblColor = UIColor.white
    let priceLblColor = UIColor.white
    
    let backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
    let addressImage = UIImage(named: "addressIconImage")
    let heartImage = UIImage(named: "heartIconImage")

    // MARK: Helper
    private var dataTask: URLSessionDataTask?
    private let homesService = HomesService()
}

extension HomeVM {
    
    init(homeItemResponse: HomeItemResponse) {
        price = HomeVM.getPrice(homeItemResponse: homeItemResponse)
        title = homeItemResponse.title.capitalized
        address = HomeVM.getAddress(homeItemResponse: homeItemResponse)
        imageUrl = HomeVM.getImageURL(homeItemResponse: homeItemResponse)
        id = homeItemResponse.advertisementId
        currency = homeItemResponse.currency
    }
    
    // MARK: Helper
    static func getImageURL(homeItemResponse: HomeItemResponse) -> String? {
        if let imageUrl = homeItemResponse.pictures.first {
            return imageUrl
        }
        return nil
    }
    
    static func getPrice(homeItemResponse: HomeItemResponse) -> String {
        if let price = homeItemResponse.price { return String(price) }
        return "Price not yet defined"
    }
    
    static func getAddress(homeItemResponse: HomeItemResponse) -> String {
        return homeItemResponse.country + ", " + homeItemResponse.city + ", " + homeItemResponse.street
    }
}

extension HomeVM {
    init(home: Home) {
        id = home.id
        price = home.price
        title = home.title
        address = home.address
        imageUrl = home.imageUrl
        isFavourite = home.isFavourite
        currency = home.currency
    }
}
