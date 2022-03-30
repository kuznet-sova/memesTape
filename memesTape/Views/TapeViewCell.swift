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
    private var likesCount = 0
    private var isChosen = false
    private let animateImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Сделать даблтап только по картинке, а не по всей ячейке пока не получилось
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        animateImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(memeInfo: Meme) {
        NetworkManager.shared.getMemeImage(with: memeInfo.url) { memeImage in
            self.likesCount = memeInfo.ups
            self.memeImageViev.image = memeImage
            self.memeAuthorLabel.text = memeInfo.author
            self.memeDescriptionLebel.text = memeInfo.title
        }
        likesCounterLebel.text = likesCountUniversal(count: likesCount)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
    }
    
    private func likesCountUniversal(count: Int) -> String {
        let formatString = NSLocalizedString("likes count",
                                                      comment: "likes count string format to be found in Localized.stringsdict")
        let resultString = String.localizedStringWithFormat(formatString, count)
    
        return resultString
    }
    
    private func getFullLikesInfo() {
        if isChosen == true {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            animateImageView.removeFromSuperview()
            likesCount -= 1
            likesCounterLebel.text = likesCountUniversal(count: likesCount)
            isChosen = false
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            memeImageViev.addSubview(animateImageView)
            animateImageView.centerXAnchor.constraint(equalTo: memeImageViev.centerXAnchor).isActive = true
            animateImageView.centerYAnchor.constraint(equalTo: memeImageViev.centerYAnchor).isActive = true
            likesCount += 1
            likesCounterLebel.text = likesCountUniversal(count: likesCount)
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
