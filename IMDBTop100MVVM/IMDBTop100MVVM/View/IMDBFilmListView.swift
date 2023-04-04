//
//  ViewController.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 1.04.2023.
//

import UIKit
import SnapKit

protocol IMDBFilmListViewDelegate: AnyObject {
    func rmCharacterListView(_ filmListView: IMDBFilmListView, didSelectCharacter film: IMDBFilmModel)
}

class IMDBFilmListView: UIView {
  
    //MARK: UI Elements
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .red
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        layout.scrollDirection = .vertical
        return collectionView
    }()
    
    var header : UILabel = {
        let label = UILabel()
        label.text = "Best of IMDb's"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    //MARK: UI Proporties
    public weak var delegate : IMDBFilmListViewDelegate?
    private let viewModel = IMDBFilmListViewViewModel()
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.delegate = self
        viewModel.fetchFilms()
        addSubviews(collectionView, header, spinner)
        spinner.startAnimating()
        setUpCollectionView()
        createSnapkitConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Functions
    private func createSnapkitConstraints(){
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        spinner.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
     
    }
    
    private func setUpCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(IMDBFilmCollectionViewCell.self, forCellWithReuseIdentifier: IMDBFilmCollectionViewCell.identifier)
    }
    //MARK: Actions
}

extension IMDBFilmListView : IMDBFilmListViewViewModelDelegate {
    func didFetchFilms() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        UIView.animate(withDuration: 0.4){
        self.collectionView.alpha = 1
        }
    }
    
    func didSelectFilm(_ character: IMDBFilmModel) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    
}




