//
//  IMDBFilmDetailView.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 4.04.2023.
//

import Foundation
import UIKit

class IMDBFilmDetailView : UIView {
    
    //MARK: UI Elements
    
    public let filmImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let filmNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
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
    
    private let filmDescriptionHeader : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private let filmDescriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 10
        return label
    }()
    
    
    private let filmYearHeader : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private let filmYearLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 10
        return label
    }()
    
    
 
    
    
    
    
    //MARK: Initializing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(filmImageView, filmNameLabel, filmDirectorLabel, filmRatingLabel,filmDescriptionHeader,filmDescriptionLabel,filmYearHeader,filmYearLabel)
        createSnapkitConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    func configure(with viewModel : IMDBFilmDetailViewViewModel){
        if let filmName = viewModel.film?.title {
            filmNameLabel.text = filmName
        }else {
            filmRatingLabel.text = "Film not found"
        }
        
        if let filmRating = viewModel.film?.rating {
            filmRatingLabel.text = "IMDb's Rating\n\(filmRating)"
        } else {
            filmRatingLabel.text = "No rating available"
        }
        
        if let filmDirector = viewModel.film?.director {
            filmDirectorLabel.text = "Director\n\(filmDirector.formatted())"
        }
        
        filmDescriptionHeader.text = "Description"
        
        if let filmDescription = viewModel.film?.description {
            filmDescriptionLabel.text = (filmDescription)
        }
        
        filmYearHeader.text = "Year"
        
        if let filmYear = viewModel.film?.year {
            filmYearLabel.text = String(describing: filmYear)
        }
        
        
        ///Fetching image closure
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
    
    func createSnapkitConstraints() {
        
        filmImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(230)
            make.top.equalToSuperview().offset(20)
        }
        
        filmNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(filmImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(filmImageView.snp.top).offset(30)
        }
        
        filmDirectorLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(filmImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(filmNameLabel.snp.bottom).offset(10)
        }
        
        filmRatingLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(filmImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(filmDirectorLabel.snp.bottom).offset(10)
            
        }
        
        filmDescriptionHeader.snp.makeConstraints { make in
            make.top.equalTo(filmImageView.snp.bottom).offset(20)
            make.left.equalTo(filmImageView.snp.left)
            make.width.equalToSuperview().offset(-150)
            make.height.equalTo(30)
        }
        
        filmDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(100)
            make.top.equalTo(filmDescriptionHeader.snp.bottom)
            
        }
        
        filmYearHeader.snp.makeConstraints { make in
            make.top.equalTo(filmDescriptionLabel.snp.bottom).offset(20)
            make.left.equalTo(filmImageView.snp.left)
            make.width.equalToSuperview().offset(-150)
            make.height.equalTo(30)
        }
        
        filmYearLabel.snp.makeConstraints { make in
            make.top.equalTo(filmYearHeader.snp.bottom)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(30)
          
        }
        
    }
    
    
    //MARK: Actions
}

//MARK: Extensions
