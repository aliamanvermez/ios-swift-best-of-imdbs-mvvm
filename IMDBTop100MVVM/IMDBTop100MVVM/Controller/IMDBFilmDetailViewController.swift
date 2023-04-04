//
//  IMDBFilmDetailViewController.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 4.04.2023.
//

import UIKit
import SnapKit
class IMDBFilmDetailViewController: UIViewController {
    private let viewModel : IMDBFilmDetailViewViewModel
    
    var detailView = IMDBFilmDetailView()
    
    init(viewModel : IMDBFilmDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(detailView)
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = false
        addConstraints()
        detailView.configure(with: viewModel)
    }
    
    func addConstraints() {
        detailView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(600)
            make.top.equalToSuperview().offset(150)
        }
    }
    

}
