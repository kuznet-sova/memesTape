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
    private var likesCount = (1...100).randomElement()
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
        getLikesCount()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
    }
    
    private func declensionLikes(likeCount: Int) -> String {
        var declensionLike: String
//        Как доделаю основное надо не забыть вынести в отдельную функцию высчитывание значений для 2 и 3 кейса, чтобы не перечислять вручную
        switch likeCount {
        case 0:
            declensionLike = ""
        case 1, 21, 31, 41, 51, 61, 71, 81, 91:
            declensionLike = "лайк"
        case 2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44, 52, 53, 54, 62, 63, 64, 72, 73, 74, 82, 83, 84, 92, 93, 94:
            declensionLike = "лайка"
        default:
            declensionLike = "лайков"
        }
        
        return declensionLike
    }
    
    private func getLikesCount() {
        guard let likes = likesCount else { return }
        
        let likesCountInfo = "\(likes) " + declensionLikes(likeCount: likes)
        likesCounterLebel.text = likesCountInfo
    }
    
    private func getFullLikesInfo() {
        if likesCount != nil {
            if isChosen == true {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                likesCount! -= 1
                getLikesCount()
                isChosen = false
            } else {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                likesCount! += 1
                getLikesCount()
                isChosen = true
            }
        }
    }
    
    @objc func doubleTapFunc() {
        getFullLikesInfo()
    }
    
    @IBAction private func likeButtonTap(_ sender: Bool) {
        getFullLikesInfo()
    }
    
}
