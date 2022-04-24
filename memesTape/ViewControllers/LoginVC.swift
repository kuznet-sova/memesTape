//
//  LoginVC.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.04.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class LoginVC: UIViewController {
    
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
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTittle = NSMutableAttributedString(string: "New to Memta? ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        attributedTittle.append(NSAttributedString(string: "Sign up", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.systemBlue]))
        button.setAttributedTitle(attributedTittle, for: .normal)
        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(logoContainerView)
        view.addSubview(dontHaveAccountButton)
        setupInputFields()
        
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 0, width: 0, height: 50)
    }
    
    private func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
    
    private func signIn(email: String, password: String, _ callback: ((Error?) -> ())? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                callback?(error)
                return
            } else {
                self.view.window?.rootViewController = UINavigationController.init(rootViewController: TapeTableVC())
            }
        }
    }
    
    @objc private func showSignUp() {
        let signUpController = SignUpVC()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func login() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        signIn(email: email, password: password)
    }
    
}
