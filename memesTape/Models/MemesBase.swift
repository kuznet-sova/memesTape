//
//  MemesBase.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

struct MemesBase: Codable {
    let success: Bool
    let data: Memes
}

struct Memes: Codable {
    let memes: [Meme]
}

struct Meme: Codable {
    let id, name: String
    let url: String
    let width, height, boxCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
}
