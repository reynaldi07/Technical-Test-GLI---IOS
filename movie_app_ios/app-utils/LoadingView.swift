//
//  BaseViewControllerKoinDeposito.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit

class LoadingView: UIView {
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()

    init(height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        addSubview(indicatorView)
        indicatorView.center = self.center
    }

    func showLoading() {
        indicatorView.startAnimating()
    }

    func hideLoading() {
        indicatorView.stopAnimating()
    }
}
