//
//  SignUpVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.04.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoTextLabel = UILabel()
        logoTextLabel.text = "Memta"
        logoTextLabel.font = .preferredFont(forTextStyle: .largeTitle)
        view.addSubview(logoTextLabel)
        logoTextLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        logoTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTittle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        attributedTittle.append(NSAttributedString(string: "Login", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.systemBlue]))
        button.setAttributedTitle(attributedTittle, for: .normal)
        button.addTarget(self, action: #selector(showSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(logoContainerView)
        view.addSubview(alreadyHaveAccountButton)
        setupInputFields()
        
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 0, width: 0, height: 50)
    }
    
    private func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 190)
    }
    
    private func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                callback?(error)
                return
            } else {
                let viewController = TapeTableVC()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @objc fileprivate func signIn() {
        guard let email = emailTextField.text, email.count > 0,
              let username = usernameTextField.text, username.count > 0,
              let password = passwordTextField.text, password.count > 0
        else { return }
        
        createUser(email: email, password: password)
    }
    
    @objc private func showSignIn() {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
