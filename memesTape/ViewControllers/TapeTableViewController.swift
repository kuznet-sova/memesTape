//
//  TapeTableViewController.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeTableViewController: UITableViewController {
    
    private var memeImages = MemeImages.getMemeImage()
    private var memeAuthors = MemeAuthors.getMemeAuthor()
    private var memeDescriptions = MemeDescriptions.getMemeDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Memes tape"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(TapeViewCell.self, forCellReuseIdentifier: "memeCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
           case self.tableView:
              return memeImages.count
            default:
              return 0
           }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TapeViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "memeCell")
        
        cell.imageView?.image = UIImage(named: memeImages[indexPath.row])
        cell.textLabel?.text = memeAuthors[indexPath.row]
        cell.detailTextLabel?.text = memeDescriptions[indexPath.row]
        
        return cell
    }
    
}
