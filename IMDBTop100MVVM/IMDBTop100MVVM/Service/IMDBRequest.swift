//
//  IMDBRequest.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 1.04.2023.
//

import Foundation

class IMDBRequest{
    
    let headers = [
                "X-RapidAPI-Key": "7e1471f67amsh57a19492b2af48ap1ba798jsn1b01ff391445",
                "X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"
            ]

    
    func request(completion : @escaping ([IMDBFilmModel]? , Error?) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: Constant.ServiceConstant.moviesServiceBaseURL())! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let models  = try decoder.decode([IMDBFilmModel].self, from: data)
                        completion(models,nil)
                        
                    }catch{
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
        })
        
        dataTask.resume()
    }
}


