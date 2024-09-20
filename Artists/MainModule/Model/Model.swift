//
//  Model.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit
import Foundation


// MARK: - Artists
struct Artists: Codable {
    var artists: [Artist]
    
    enum CodingKeys: CodingKey {
        case artists
    }
    
}


// MARK: - Artist
struct Artist: Codable {
    var name, bio, image: String
    var works: [Work]
    
    enum CodingKeys: CodingKey {
        case name
        case bio
        case image
        case works
    }
    
}


// MARK: - Work
struct Work: Codable {
    var title, image, info: String?
    
    enum CodingKeys: CodingKey {
        case title
        case image
        case info
    }

}


//struct Comment: Decodable {
//    var postId: Int
//    var id: Int
//    var name: String
//    var email: String
//    var body: String
//
//}


//
//// MARK: - Arts
//struct Arts: Decodable {
//    let artists: Artist?
//    
////    init(artists: Artist?) {
////        self.artists = artists
////    }
////    
////    init(artData: [String: Any]) {
////        artists = artData["artists"] as? Artist
////    }
////    
////    static func getArt(from jsonValue: Any) -> [Arts] {
////        guard let artistData = jsonValue as? [[String: Any]] else {return []}
////        return artistData.map { Arts(artData: $0)}
////    }
//}
//
//
//
//// MARK: - Artist
//struct Artist: Decodable {
//    let name, bio, image: String?
//    let works: Work?
////    
////    init(name: String?, bio: String?, image: String?, works: Work?) {
////        self.name = name
////        self.bio = bio
////        self.image = image
////        self.works = works
////    }
////    
////    init(artistData: [String: Any]) {
////        name = artistData["name"] as? String ?? ""
////        bio = artistData["bio"] as? String ?? ""
////        image = artistData["image"] as? String ?? ""
////        works = artistData["works"] as? Work
////    }
//}
//
//// MARK: - Work
//struct Work: Decodable {
//    let title, image, info: String?
//    
//    
////    init(title: String?, image: String?, info: String?) {
////        self.title = title
////        self.image = image
////        self.info = info
////    }
////    
////    init(workData: [String: Any]) {
////        title = workData["title"] as? String? ?? ""
////        image = workData["image"] as? String? ?? ""
////        info = workData["info"] as? String? ?? ""
////    }
//}
//
//
//
