//
//  SpinnerViewController.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 01.04.2022.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return spinner
    }
}
