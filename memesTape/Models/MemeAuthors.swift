//
//  MemeAuthors.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

struct MemeAuthors {
    let memeAuthors = [
        "1",
        "2",
        "3"
    ]
}

extension MemeAuthors {
    static func getMemeAuthor() -> [String] {
        var memeAuthorsList = [String]()

        for index in 0 ..< MemeAuthors().memeAuthors.count {
            memeAuthorsList.append(MemeAuthors().memeAuthors[index])
        }
        return memeAuthorsList
    }
}
