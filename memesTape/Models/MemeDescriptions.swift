//
//  MemeDescriptions.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

struct MemeDescriptions {
    let memeDescriptions = [
        "111",
        "222",
        "333"
    ]
}

extension MemeDescriptions {
    static func getMemeDescription() -> [String] {
        var memeDescriptionsList = [String]()

        for index in 0 ..< MemeDescriptions().memeDescriptions.count {
            memeDescriptionsList.append(MemeDescriptions().memeDescriptions[index])
        }
        return memeDescriptionsList
    }
}
