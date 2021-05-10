//
//  HomesVM.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 10.5.21..
//

import UIKit

class HomesVM {
    
    // MARK: - API
    var isLoadingScreenShown = true
    let homeListTitle = "Catalog List"
    let loadFailText = "Failed to load..."
    let backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)

    init(isLoadingScreenShown: Bool) {
        self.isLoadingScreenShown = isLoadingScreenShown
    }
    
    func cancelCatalogsFetch() {
        dataTask?.cancel()
    }
    
    func persist(homes: [HomeVM]) {
        let homes = homes.map { Home(homeVM: $0) }
        let encoder = JSONEncoder()
        let data = try? encoder.encode(homes)
        UserDefaultsHelper.shared.homes = data
    }
    
    func loadPersistedHomes(success: ([HomeVM]) -> Void, fail: () -> Void) {
        guard let homesData = UserDefaultsHelper.shared.homes else {
            fail()
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedHomes = try decoder.decode([Home].self, from: homesData)
            let homesVMs = decodedHomes.map { HomeVM(home: $0)}
            success(homesVMs)
        } catch {
            fail()
        }
    }
    
    func fetchHomes(completion: @escaping (Result<[HomeVM], NetworkError>) -> ()) {
        fetchData { result in
            completion(result)
        }
    }
    
    func filterForFavHomes(fetchedHomes: [HomeVM], existingHomes: [HomeVM]) -> [HomeVM] {
        var fetchedHomes = fetchedHomes
        let existingHomes = existingHomes
        
        let favoruiteHomes = existingHomes.filter { $0.isFavourite == true}
        
        for favoruiteHome in favoruiteHomes {
            if let row = fetchedHomes.firstIndex(where: {$0.id == favoruiteHome.id }) {
                fetchedHomes[row] = favoruiteHome
            }
        }
        return fetchedHomes.count > 0 ? fetchedHomes : existingHomes
    }

    // MARK: - Properties

    private var dataTask: URLSessionDataTask?
    private let homesService = HomesService()
    
    // MARK: - Helper
    private func fetchData(completion: @escaping (Result<[HomeVM], NetworkError>) -> ()) {
        
        dataTask = homesService.fetchHomes { result in
            
            switch result {
            case .success(let homesRes):
                guard let homesResponse = homesRes else { return }
                let homes = homesResponse.items.map { HomeVM(homeItemResponse: $0) }
                completion(.success(homes))
                
            case .failure(let err):
                completion(.failure(NetworkError.error(err: err)))
            }
        }
    }
}
