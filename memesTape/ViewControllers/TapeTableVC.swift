//
//  TapeTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeTableVC: UITableViewController {
    private var memes: [Meme] = []
    var messagesHistory: [Int : [Message]] = [:]
    var likesHistory: [Int : Int] = [:]
    var likeTapHistory: [Int : Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Memes tape"
        setupTableView()
        
        NetworkManager.shared.fetchData(postCount: 5) { memesBase in
            DispatchQueue.main.async {
                self.memes = memesBase.memes
                self.tableView.reloadData()
            }
        }
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: TapeViewCell.reuseIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: TapeViewCell.reuseIdentifier)
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TapeViewCell.reuseIdentifier, for: indexPath) as! TapeViewCell
        cell.cellIndex = indexPath.row
        
        if let likes = likesHistory[indexPath.row] {
            cell.likesCount = likes
        }
        if let likeTap = likeTapHistory[indexPath.row] {
            cell.isChosen = likeTap
        }
        cell.configure(memeInfo: memes[indexPath.row])
        cell.cellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewSides = [tableView.frame.width, tableView.frame.height]
        
        guard let minSide = tableViewSides.min() else {
            return tableView.frame.width/2
        }
        
        return minSide
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == memes.count-1 {
            NetworkManager.shared.fetchData(postCount: 5) { memesBase in
                DispatchQueue.main.async {
                    self.memes.append(contentsOf: memesBase.memes)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func callPullToRefresh(){
        let historyMemesList = memes
        
        NetworkManager.shared.fetchData(postCount: 1) { memesBase in
            var newMessagesDictionary: [Int : [Message]] = [:]
            var newLikesDictionary: [Int : Int] = [:]
            var newLikeTapDictionary: [Int : Bool] = [:]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                for key in 0...self.likesHistory.keys.count {
                    if let oldValue = self.likesHistory[key] {
                        newLikesDictionary.updateValue(oldValue, forKey: key + 1)
                    }
                }
                for key in 0...self.likeTapHistory.keys.count {
                    if let oldValue = self.likeTapHistory[key] {
                        newLikeTapDictionary.updateValue(oldValue, forKey: key + 1)
                    }
                }
                self.likesHistory = newLikesDictionary
                self.memes = memesBase.memes
                self.memes.append(contentsOf: historyMemesList)
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                
                for key in 0...self.messagesHistory.keys.count {
                    if let oldValue = self.messagesHistory[key] {
                        newMessagesDictionary.updateValue(oldValue, forKey: key + 1)
                    }
                }
                self.messagesHistory = newMessagesDictionary
            }
        }
    }
    
}

extension TapeTableVC: CellDelegate {
    func openMessagesVC(messageInfo: Message, index: Int, likes: Int, likeTap: Bool) {
        likesHistory.updateValue(likes, forKey: index)
        likeTapHistory.updateValue(likeTap, forKey: index)
        
        let messagesTableVC: MessagesTableVC = MessagesTableVC()
        messagesTableVC.messagesTableVCDelegate = self
        messagesTableVC.cellIndex = index
        
        if let history = messagesHistory[index] {
            messagesTableVC.messagesInfo = history
        } else {
            messagesTableVC.messagesInfo.append(messageInfo)
        }
        navigationController?.pushViewController(messagesTableVC, animated: true)
    }
}

extension TapeTableVC: MessagesTableVCDelegate {
    func saveHistory(messages: [Message], index: Int) {
        messagesHistory.updateValue(messages, forKey: index)
        tableView.reloadData()
    }
}
