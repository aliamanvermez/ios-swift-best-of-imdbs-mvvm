//
//  IMDBFilmModel.swift
//  IMDBTop100MVVM
//
//  Created by Ali Amanvermez on 1.04.2023.
//

import Foundation

struct IMDBFilmModel : Codable {
     let rank: Int?
     let title: String?
     let thumbnail: String?
     let rating, id: String?
     let year: Int?
     let image: String?
     let description: String?
     let trailer: String?
     let genre, director, writers: [String]?
     let imdbid: String?
        
 }





// typealias Welcome = [IMDBFilmModel]
// @propertyWrapper public struct NilOnFail<T: Codable>: Codable {
//     
//     public let wrappedValue: T?
//     public init(from decoder: Decoder) throws {
//         wrappedValue = try? T(from: decoder)
//     }
//     public init(_ wrappedValue: T?) {
//         self.wrappedValue = wrappedValue
//     }
// }


