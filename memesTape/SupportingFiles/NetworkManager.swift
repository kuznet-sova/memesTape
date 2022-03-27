//
//  NetworkManager.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(with complition: @escaping (MemesBase) -> Void) {
        let memesUrl = "https://api.imgflip.com/get_memes"
        
        guard let url = URL(string: memesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let memesBase = try JSONDecoder().decode(MemesBase.self, from: data)
                complition(memesBase)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
}
