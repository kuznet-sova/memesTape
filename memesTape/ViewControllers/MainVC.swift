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
//        self.modalPresentationStyle = .fullScreen
        delegate = self
        
        signOut()
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
    
}
