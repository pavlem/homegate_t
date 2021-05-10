//
//  HomeImageView.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 10.5.21..
//

import UIKit

class HomeImageView: UIImageView {
    
    // MARK: - API
    var vm: HomeImageVM! {
        didSet {
            setImage(withName: vm.imageName) { _ in }
        }
    }
    
    // MARK: - Helper
    private func setImage(withName imageName: String, fail: @escaping (NetworkError) -> Void) {
        if let image = vm?.getCachedImage(imageName: imageName) {
            
            set(image: image)
            return
        }
        
        urlSessionDataTask = homesService.fetch(image: imageName, completion: { (result) in
            switch result {
            case .failure(let err):
                fail(err)
                if let img = self.vm?.fetchMOC() {
                    self.vm?.cache(image: img, key: imageName)
                    self.set(image: img, withTransition: self.imgTransitionDuration)
                }
            case .success(let image):
                self.vm?.cache(image: image, key: imageName)
                self.set(image: image, withTransition: self.imgTransitionDuration)
            }
        })
    }
    
    // MARK: - Properties
    private var urlSessionDataTask: URLSessionDataTask?
    private let homesService = HomesService()
    private let imgPlaceholder = "imgPlaceholder"

    private let imgTransitionDuration = 0.9
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image = UIImage(named: imgPlaceholder)
    }
    
    // MARK: - Helper
    private func set(image: UIImage, withTransition transition: Double? = nil) {
        guard let transition = transition else {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        DispatchQueue.main.async {
            self.image = nil
            UIView.transition(with: self,
                              duration: transition,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
        }
    }
}
