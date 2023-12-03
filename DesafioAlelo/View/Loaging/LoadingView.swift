//
//  LoadingView.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 02/12/23.
//


import UIKit

class LoadingView: UIView {

    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = UIColor(white: 1, alpha: 0.8)
        addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func startLoading() {
        activityIndicatorView.startAnimating()
        isHidden = false
    }

    func stopLoading() {
        activityIndicatorView.stopAnimating()
        isHidden = true
    }
}
