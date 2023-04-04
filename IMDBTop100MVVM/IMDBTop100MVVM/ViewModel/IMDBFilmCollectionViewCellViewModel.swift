//
//  IMDBFilmCollectionViewCellViewModel.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import Foundation

final class IMDBFilmCollectionViewCellViewModel {
    public let filmName : String?
    public let filmRating : String?
    public let filmDirectorName : [String]?
    public let filmImageURL : URL?
    
    init(filmName: String?, filmRating: String?, filmDirectorName: [String]?, filmImageURL: URL?) {
        self.filmName = filmName
        self.filmRating = filmRating
        self.filmDirectorName = filmDirectorName
        self.filmImageURL = filmImageURL
    }
    public func fetchImage(completion : @escaping (Result <Data, Error>) -> Void) {
        //TODO: Abstract to Image Manager
        guard let url = filmImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}


