//
//  HomeImageVM.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 11.5.21..
//

import UIKit

struct HomeImageVM {
    var imageName: String
    var imagePlaceholderName = "imgPlaceholder"
}

extension HomeImageVM {
    func getCachedImage(imageName: String) -> UIImage? {
        if let image = ImageHelper.shared.imageCache.object(forKey: imageName as NSString) {
            return image
        }
        return nil
    }
    
    func fetchMOC() -> UIImage? {
       return ImageHelper.shared.fetchMOCImage()
    }
    
    func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
}

extension HomeImageVM {
    var mocImage: UIImage? {
        ImageHelper.shared.fetchMOCImage()
    }
}
