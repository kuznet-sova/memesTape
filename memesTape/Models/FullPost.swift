//
//  FullPost.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

struct FullPost {
    let memeImageName: String
    let memeAuthor: String
    let memeDescription: String
}

extension FullPost {
    static func getFullPostInfo() -> [FullPost] {
        var fullPostInfo = [FullPost]()

        for index in 0 ..< MemeImages().memeImages.count {
            fullPostInfo.append (
                FullPost (
                    memeImageName: MemeImages().memeImages[index],
                    memeAuthor: MemeAuthors().memeAuthors[index],
                    memeDescription: MemeDescriptions().memeDescriptions[index]
                )
            )
        }
        return fullPostInfo
    }
}

