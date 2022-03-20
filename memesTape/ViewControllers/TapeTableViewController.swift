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
//        view.backgroundColor = .green
        navigationItem.title = "Memes tape"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(TapeViewCell.self, forCellReuseIdentifier: "memeCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)

        return cell
    }
    
}
