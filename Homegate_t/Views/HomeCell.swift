//
//  HomesCell.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    // MARK: - API

    static let id = "HomeCellID"

    var vm: HomeVM? {
        willSet {
            updateUI(vm: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var homeImageView: HomeImageView!
    @IBOutlet weak var addressIconImageView: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: HomegateLbl!
    @IBOutlet weak var saveSymbolImgView: UIImageView!
    
    // MARK: - Private
    private func updateUI(vm: HomeVM?) {
        guard let vm = vm else { return }
        priceLbl.text = vm.priceDescription
        addressLbl.text = vm.address
        titleLbl.text = vm.title
        
        priceLbl.font = vm.priceLblFont
        addressLbl.font = vm.addressLblFont
        titleLbl.font = vm.titleLblFont
        
        priceLbl.textColor = vm.priceLblColor
        addressLbl.textColor = vm.addressLblColor
        titleLbl.textColor = vm.titleLblColor
        
        contentView.backgroundColor = vm.backgroundColor
        
        addressIconImageView.image = vm.addressImage
        saveSymbolImgView.image = vm.heartImage

        if let imgName = vm.imageUrl {
            homeImageView.vm = HomeImageVM(imageName: imgName)
        }
        
        saveSymbolImgView.isHidden = !vm.isFavourite
    }
}



