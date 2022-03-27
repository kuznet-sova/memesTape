//
//  NetworkManager.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(with complition: @escaping ([MemesBase]) -> Void) {
        let memesUrl = "https://api.memegen.link/images"
        
        guard let url = URL(string: memesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let memesBase = try JSONDecoder().decode([MemesBase].self, from: data)
                complition(memesBase)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchTemplateData(url: String, with complition: @escaping (Template) -> Void) {
        let templateURL = url
        
        guard let url = URL(string: templateURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let templateList = try JSONDecoder().decode(Template.self, from: data)
                complition(templateList)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
    
    func getMemeImage(with url: String?, with complition: @escaping (UIImage) -> Void) {
        guard let memeImageUrl = url else { return }
        
        guard let stringMemeImageUrl = URL(string: memeImageUrl),
            let memeImageData = try? Data(contentsOf: stringMemeImageUrl),
            let memeImage = UIImage(data: memeImageData) else { return }
        
        complition(memeImage)
    }

}
