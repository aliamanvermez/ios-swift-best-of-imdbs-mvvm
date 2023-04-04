//
//  ServiceConstant.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 2.04.2023.
//

import Foundation

extension Constant{
    
    enum ServiceConstant : String{
        case BASE_URL = "https://imdb-top-100-movies.p.rapidapi.com"
        case API_KEY = "7e1471f67amsh57a19492b2af48ap1ba798jsn1b01ff391445"
        
        static func moviesServiceBaseURL () -> String{
            "\(BASE_URL.rawValue)"
        }
        
        static func moviesService_API_KEY () -> String{
            "\(BASE_URL.rawValue)"
        }
        
    }
    
  
}
