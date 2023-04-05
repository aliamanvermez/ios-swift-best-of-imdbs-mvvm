//
//  RMCharacterCollectionViewCell.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import Foundation
import UIKit.UICollectionViewCell

final class IMDBFilmCollectionViewCell : UICollectionViewCell{
    
    static let identifier = "IMDBFilmCollectionViewCell"
    
    public let filmImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let filmNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let filmDirectorLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let filmRatingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(filmImageView, filmNameLabel, filmDirectorLabel, filmRatingLabel)
        contentView.backgroundColor = .gray
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        filmImageView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        filmNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-140)
            make.left.equalTo(filmImageView.snp.right)
            make.height.equalTo(50)
            
        }
        
        filmDirectorLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-140)
            make.top.equalTo(filmNameLabel.snp.bottom).offset(5)
            make.left.equalTo(filmNameLabel.snp.left)
            make.height.equalTo(60)
            
        }
        
        filmRatingLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-140)
            make.top.equalTo(filmDirectorLabel.snp.bottom).offset(5)
            make.left.equalTo(filmNameLabel.snp.left)
            make.height.equalTo(60)
            
        }
    }
    
    public func configure(with viewModel : IMDBFilmCollectionViewCellViewModel) {
        
        if let filmName = viewModel.filmName {
            filmNameLabel.text = filmName
        }else {
            filmRatingLabel.text = "Film not found"
        }
        
        if let filmRating = viewModel.filmRating {
            filmRatingLabel.text = "IMDB's Rating\n\(filmRating)"
        } else {
            filmRatingLabel.text = "No rating available"
        }
        
        if let filmDirector = viewModel.filmDirectorName?.formatted() {
            filmDirectorLabel.text = "Director \n \(filmDirector)"
        }
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.filmImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    

    
}
