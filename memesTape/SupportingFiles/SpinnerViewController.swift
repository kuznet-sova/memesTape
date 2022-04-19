//
//  SpinnerViewController.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 01.04.2022.
//

import UIKit

class SpinnerViewController {
    private var spinner = UIActivityIndicatorView(style: .large)
    
    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .gray
        
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return spinner
    }
    
}
