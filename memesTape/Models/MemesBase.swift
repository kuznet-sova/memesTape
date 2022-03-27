//
//  MemesBase.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

struct MemesBase: Decodable {
    let url: String
    let template: String
}

struct Template: Decodable {
    let id: String
    let name: String
}
