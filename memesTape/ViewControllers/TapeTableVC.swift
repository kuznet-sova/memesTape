//
//  TapeTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeTableVC: UITableViewController {
    var fullPost = FullPost.getFullPostInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Memes tape"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: TapeViewCell.reuseIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: TapeViewCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullPost.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TapeViewCell.reuseIdentifier, for: indexPath) as! TapeViewCell
        let fullPost = fullPost[indexPath.row]

        cell.memeImageViev?.image = UIImage(named: fullPost.memeImageName)
        cell.memeAuthorLabel?.text = fullPost.memeAuthor
        cell.memeDescriptionLebel?.text = fullPost.memeDescription

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.frame.width < tableView.frame.height {
            return tableView.frame.width
        } else {
            return tableView.frame.height
        }
    }
    
}