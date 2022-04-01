//
//  NetworkManager.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(postCount: Int, with complition: @escaping (MemesBase) -> Void) {
        let memesUrl = "https://meme-api.herokuapp.com/gimme/\(postCount)"
        
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
    
    func getMemeImage(with url: String?, with complition: @escaping (UIImage) -> Void) {
        guard let memeImageUrl = url,
              let stringMemeImageUrl = URL(string: memeImageUrl)
        else {
            complition(UIImage(named: "defaultImage.jpg")!)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let memeImage: UIImage?
            
            if let memeImageData = try? Data(contentsOf: stringMemeImageUrl) {
                memeImage = UIImage(data: memeImageData)
            } else {
                memeImage = UIImage(named: "defaultImage.jpg")
            }
            
            DispatchQueue.main.async {
                complition(memeImage!)
            }
        }
    }
    
}
