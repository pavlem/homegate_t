//
//  CatalogService.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import UIKit

class HomesService: NetworkService {
    
    // MARK: - API
    func fetch(image imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {
        
        guard let url = URL(string: imageUrl) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(img))
        }
        task.resume()
        return task
    }
    
    func fetchHomes(completion: @escaping (Result<HomeResponse?, NetworkError>) -> ()) -> URLSessionDataTask? {
        
        return load(urlString: urlString, path: path, method: .get, params: nil, headers: nil) { (result: Result<HomeResponse?, NetworkError>) in
            
            switch result {
            case .success(let catalogResponse):
                completion(.success(catalogResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    // MARK: - Properties
    private let scheme = "http://"
    private let host = "private-492e5-homegate1.apiary-mock.com/"
    private let path = "properties"

    private var urlString: String {
        return scheme + host
    }
}
