//
//  MemeImages.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

struct MemeImages {
    let memeImages = [
        "i1",
        "i2",
        "i3"
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
