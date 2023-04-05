//
//  IMDBFilmListViewController.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import UIKit
import SnapKit
class IMDBFilmListViewController: UIViewController, IMDBFilmListViewDelegate {

    var filmListView = IMDBFilmListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(filmListView)
        view.backgroundColor = .black
        createSnapkit()
        configureNavigationController()
        
        
    }
    
    func createSnapkit() {
        filmListView.delegate = self
        filmListView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func configureNavigationController(){
        title = "Best of IMDb's"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    func imdbFilmListView(_ filmListView: IMDBFilmListView, didSelectCharacter film: IMDBFilmModel) {
        let viewModel = IMDBFilmDetailViewViewModel(film: film)
        let detailVC = IMDBFilmDetailViewController(viewModel: viewModel)
        print("çalıştı")
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
    
    
}
