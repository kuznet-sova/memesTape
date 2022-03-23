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
    
    var likesCount = (1...100).randomElement()!
    static let reuseIdentifier = String(describing: TapeViewCell.self)
    
    func configure(fullPost: FullPost) {
        memeImageViev.image = UIImage(named: fullPost.memeImageName)
        memeAuthorLabel.text = fullPost.memeAuthor
        memeDescriptionLebel.text = fullPost.memeDescription
        likesCounterLebel.text = "\(likesCount)"
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
    }
    
    @IBAction func likeButtonTap(_ sender: Any) {}
    
}
