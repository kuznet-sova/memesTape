//
//  TapeViewCell.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeViewCell: UITableViewCell {
    
    @IBOutlet var memeImageViev: UIImageView!
    @IBOutlet var likesCounterLebel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var memeAuthorLabel: UILabel!
    @IBOutlet var memeDescriptionLebel: UILabel!
    
    static let reuseIdentifier = String(describing: TapeViewCell.self)
    private var randomInt = Int.random(in: 1...100)
    private var isChosen = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Сделать даблтап только по картинке, а не по всей ячейке пока не получилось
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func configure(fullPost: FullPost) {
        memeImageViev.image = UIImage(named: fullPost.memeImageName)
        memeAuthorLabel.text = fullPost.memeAuthor
        memeDescriptionLebel.text = fullPost.memeDescription
        likesCounterLebel.text = likesCountUniversal(count: randomInt)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
    }
    
    private func likesCountUniversal(count: Int) -> String {
        let formatString : String = NSLocalizedString("likes count",
                                                      comment: "likes count string format to be found in Localized.stringsdict")
        let resultString : String = String.localizedStringWithFormat(formatString, count)
    
        return resultString;
    }
    
    private func getFullLikesInfo() {
        if isChosen == true {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            randomInt -= 1
            likesCounterLebel.text = likesCountUniversal(count: randomInt)
            isChosen = false
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            randomInt += 1
            likesCounterLebel.text = likesCountUniversal(count: randomInt)
            isChosen = true
        }
    }
    
    @objc func doubleTapFunc() {
        getFullLikesInfo()
    }
    
    @IBAction private func likeButtonTap(_ sender: Bool) {
        getFullLikesInfo()
    }
    
}
