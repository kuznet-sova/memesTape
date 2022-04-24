//
//  MainVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.04.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MainVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
        
        signOut()
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(LoginVC(), animated: true)
            }
            return
        }
    }
    
    @objc private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch { return }
    }
    
}
