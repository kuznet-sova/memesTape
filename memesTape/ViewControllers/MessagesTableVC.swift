//
//  MessagesTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 03.04.2022.
//

import UIKit

class MessagesTableVC: UITableViewController {
    var messagesInfo: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Messages"
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: MessagesViewCell.reuseIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: MessagesViewCell.reuseIdentifier)
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessagesViewCell.reuseIdentifier, for: indexPath) as! MessagesViewCell
        
        cell.messageAuthor.text = messagesInfo[indexPath.row].author
        cell.messageDescription.text = messagesInfo[indexPath.row].description
        
        return cell
    }
}
