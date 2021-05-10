//
//  HomesCVC.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import UIKit

class HomesCVC: UICollectionViewController, Storyboarded {
    
    // MARK: - API
    weak var coordinator: MainCoordinator?
        
    // MARK: - Properties
    private var homes = [HomeVM]()
    private var homesVM: HomesVM! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setModels()
        setUI()
        loadPersistedHomes()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchHomes()
    }
    
    // MARK: - Helper
    private func fetchHomes() {
        homesVM.fetchHomes { [weak self] result in
            guard let `self` = self else { return }
  
            switch result {
            case .failure(let err):
                AlertHelper.simpleAlert(message: err.errorDescription, vc: self) {
                    self.homesVM = HomesVM(isLoadingScreenShown: false)
                }
            case .success(let homes):

                self.homes = self.homesVM.filterForFavHomes(fetchedHomes: homes, existingHomes: self.homes)
                self.homesVM = HomesVM(isLoadingScreenShown: false)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private func setModels() {
        homesVM = HomesVM(isLoadingScreenShown: true)
    }
    
    private func loadPersistedHomes() {
        homesVM.loadPersistedHomes { homes in
            self.homes = homes
        } fail: {}
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.homesVM.isLoadingScreenShown ? BlockingScreen.start(vc: self) : BlockingScreen.stop()
        }
    }
    
    private func setUI() {
        title = homesVM.homeListTitle
        collectionView.backgroundColor = homesVM.backgroundColor
    }
}

// MARK: UICollectionViewDataSource
extension HomesCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.id, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        cell.vm = homes[indexPath.row]
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomesCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vm = homes[indexPath.row]
        return CGSize(width: self.view.frame.size.width, height: vm.cellHeight)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var home = homes[indexPath.row]
        home.isFavourite = !home.isFavourite
        homes[indexPath.row] = home
        collectionView.reloadItems(at: [indexPath])
        homesVM.persist(homes: homes)
    }
}
