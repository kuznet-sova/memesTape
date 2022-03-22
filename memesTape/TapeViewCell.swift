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

}
