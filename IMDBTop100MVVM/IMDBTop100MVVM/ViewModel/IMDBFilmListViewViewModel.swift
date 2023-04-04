//
//  IMDBFilmListViewViewModel.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import Foundation
import UIKit.UICollectionView

protocol IMDBFilmListViewViewModelDelegate: AnyObject {
    func didFetchFilms() ///Filmlerin fetch ediliğ edilmediği bilgisini dinleyen fonksiyon
    func didSelectFilm(_ character : IMDBFilmModel) ///Hangi filmin seçildiğini dinleyen fonksiyon
    
}

final class IMDBFilmListViewViewModel : NSObject {
    
    ///imdbFilms içine  IMDBFilmCollectionViewCellViewModel tanımlamamızın sebebi IMDBFilmCollectionViewCellViewModel içinde tekraren bi fetch fonksiyonu yazmanın mantıksız olmasıdır
    
    var imdbFilms : [IMDBFilmModel] = []{
        didSet{
            for imdbFilm in imdbFilms {
                let viewModel = IMDBFilmCollectionViewCellViewModel(filmName: imdbFilm.title, filmRating: imdbFilm.rating, filmDirectorName: imdbFilm.director, filmImageURL: URL(string: imdbFilm.image ?? "no image"))
                cellViewModel.append(viewModel)
                
            }
        }
    }
    
    public weak var delegate: IMDBFilmListViewViewModelDelegate?
    public var cellViewModel : [IMDBFilmCollectionViewCellViewModel] = []
    
    
    func fetchFilms(){
        let request = IMDBRequest()
        request.request { models, error in
            if let error = error {
                print("Error fetching films: \(error.localizedDescription)")
                
            }
            else if let models = models {
                self.imdbFilms = models
                DispatchQueue.main.async {
                    self.delegate?.didFetchFilms()
                }
                
            }
        }
    }
    
}

extension IMDBFilmListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IMDBFilmCollectionViewCell.identifier, for: indexPath) as! IMDBFilmCollectionViewCell
        let viewModel = cellViewModel[indexPath.row]
        cell.backgroundColor = .black
        cell.configure(with: viewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let film = imdbFilms[indexPath.row]
        delegate?.didSelectFilm(film)
        
    }
    
}






