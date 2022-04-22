//
//  MessagesViewCell.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 03.04.2022.
//

import UIKit

class MessagesViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MessagesViewCell.self)
    
    @IBOutlet var messageAuthor: UILabel!
    @IBOutlet var messageDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
