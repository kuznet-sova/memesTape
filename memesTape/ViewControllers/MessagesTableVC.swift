//
//  MessagesTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 03.04.2022.
//

import UIKit

protocol MessagesTableVCDelegate: AnyObject {
    func saveHistory(messages: [Message], index: Int)
}

class MessagesTableVC: UITableViewController {
    weak var messagesTableVCDelegate: MessagesTableVCDelegate?
    var messagesInfo: [Message] = []
    var commentAuthor = ""
    var cellIndex = 0
    
    override var inputAccessoryView: UIView? {
        return containerView
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private lazy var containerView: AddCommentView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let addCommentView = AddCommentView(frame: frame)
        addCommentView.delegate = self
        return addCommentView
    }()
    
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
        
        commentAuthor = messagesInfo[indexPath.row].author
        cell.messageAuthor.text = messagesInfo[indexPath.row].author
        cell.messageDescription.text = messagesInfo[indexPath.row].description
        
        return cell
    }
    
}

extension MessagesTableVC: AddCommentViewDelegate {
    func didSubmit(comment: String) {
        let newComment = Message(author: commentAuthor, description: comment)
        messagesInfo.append(newComment)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.containerView.clearCommentTextField()
        messagesTableVCDelegate?.saveHistory(messages: messagesInfo, index: cellIndex)
    }
}
