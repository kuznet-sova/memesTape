//
//  TapeTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeTableVC: UITableViewController {
    private var fullPost = FullPost.getFullPostInfo()
    private var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Meme patterns"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        
        NetworkManager.shared.fetchData() { memesBase in
            DispatchQueue.main.async {
                self.memes = memesBase.data.memes
                self.tableView.reloadData()
            }
        }
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
        
        cell.configure(memeInfo: memes[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewSides = [tableView.frame.width, tableView.frame.height]

        guard let minSide = tableViewSides.min() else {
            return tableView.frame.width/2
        }
        
        return minSide
    }
    
}
