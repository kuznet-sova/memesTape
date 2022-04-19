//
//  NetworkManager.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private var cashedImages: [String : UIImage] = [:]
    
    func fetchData(postCount: Int, with complition: @escaping (MemesBase) -> Void) {
        let memesUrl = URL.memesUrl + String(postCount)
        
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
        let memeImageUrl = url
        guard let stringMemeImageUrl = memeImageUrl else { return }
        
        if memeImageUrl == nil {
            complition(UIImage(named: "defaultImage.jpg")!)
        } else {
            if let cashedImage = self.cashedImages[stringMemeImageUrl] {
                complition(cashedImage)
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                guard let memeImageUrl = URL(string: stringMemeImageUrl),
                      let memeImageData = try? Data(contentsOf: memeImageUrl),
                      let memeImage = UIImage(data: memeImageData) else { return }
                
                DispatchQueue.main.async {
                    self.cashedImages.updateValue(memeImage, forKey: stringMemeImageUrl)
                    complition(memeImage)
                }
            }
        }
    }
    
}

extension URL {
    static var memesUrl: String {
        String("https://meme-api.herokuapp.com/gimme/")
    }
}
