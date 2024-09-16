//
//  Model.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit
import Foundation

struct Artists: Codable {
    let artists: [Person]
}

struct Person: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Codable {
    let title: String
    let image: String
    let info: String
}



