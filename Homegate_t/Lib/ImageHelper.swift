//
//  ImageHelper.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 11.5.21..
//

import UIKit

class ImageHelper {

    // MARK: - API
    func fetchMOCImage() -> UIImage? {
        guard let imageName = mocImages.first else { return nil }
        mocImages.removeFirst()
        return UIImage(named: imageName)
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageHelper()
    
    // MARK: - Properties
    private var mocImages = [String]()
    
    // MARK: - Inits
    init() {
        for index in 1...10 {
            mocImages.append("houseMocImg\(index)")
        }
    }
}
