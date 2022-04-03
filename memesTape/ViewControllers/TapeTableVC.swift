//
//  TapeTableVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeTableVC: UITableViewController {
    private var memes: [Meme] = []
    private let refreshLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Memes tape"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setRefreshLabel()
        refreshLabel.isHidden = true
        
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
    
    private func setRefreshLabel() {
        refreshLabel.textColor = .gray
        refreshLabel.textAlignment = .left
        refreshLabel.text = "Loading..."
        //        Хотела добавить лейбл над навбаром, но кроме как подбор значений не нашла способ.
        //        Подскажите есть ли какой вариант указать расположение лейбла над навигешн контроллером?
        refreshLabel.frame = CGRect(x: 20, y: -100, width: 80, height: 30)
        
        tableView.addSubview(refreshLabel)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TapeViewCell.reuseIdentifier, for: indexPath) as! TapeViewCell
        
        cell.spinnerView?.startAnimating()
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
        if tableView.refreshControl?.isRefreshing == true{
            self.refreshLabel.isHidden = false
        }
        
        NetworkManager.shared.fetchData(postCount: 1) { memesBase in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.memes = memesBase.memes
                self.memes.append(contentsOf: historyMemesList)
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.refreshLabel.isHidden = true
            }
        }
    }
    
}

extension TapeTableVC: CellDelegate {
    func openMessagesVC(messageInfo: Message) {
        let messagesTableVC: MessagesTableVC = MessagesTableVC()
        messagesTableVC.messagesInfo.append(messageInfo)
        navigationController?.pushViewController(messagesTableVC, animated: true)
    }
}
