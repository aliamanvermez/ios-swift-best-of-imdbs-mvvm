//
//  IMDBFilmDetailViewViewModel.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 4.04.2023.
//

import Foundation

final class IMDBFilmDetailViewViewModel {
    var film: IMDBFilmModel?
    init(film: IMDBFilmModel) {
          self.film = film
      }
    
    
    public func fetchImage(completion : @escaping (Result <Data, Error>) -> Void) {
        let filmImageURL = URL(string: film?.image ?? "no image")
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
