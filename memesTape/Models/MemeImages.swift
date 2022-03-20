//
//  MemeImages.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

struct MemeImages {
    let memeImages = [
        "i1.jpg",
        "i2.jpg",
        "i3.jpg"
    ]
}

extension MemeImages {
    static func getMemeImage() -> [String] {
        var memeImagesList = [String]()

        for index in 0 ..< MemeImages().memeImages.count {
            memeImagesList.append(MemeImages().memeImages[index])
        }
        return memeImagesList
    }
}
