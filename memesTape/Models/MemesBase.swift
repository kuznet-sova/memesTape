//
//  MemesBase.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 26.03.2022.
//

struct MemesBase: Decodable {
    let count: Int
    let memes: [Meme]
}

struct Meme: Decodable {
    let postLink: String
    let subreddit, title: String
    let url: String
    let nsfw, spoiler: Bool
    let author: String
    let ups: Int
    let preview: [String]
}
