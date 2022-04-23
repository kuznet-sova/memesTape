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
        
        AppDelegate().window?.rootViewController = UINavigationController.init(rootViewController: TapeTableVC())
//        let signOutButton = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
//        navigationItem.rightBarButtonItem  = signOutButton
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
    
}
