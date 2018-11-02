//
//  Character.swift
//  Promises
//
//  Created by federico mazzini on 02/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

class Character: Decodable {
    
    var name: String!
    var imageURL: String!
    var bio: String!
    
    init(name: String, imageURL: String, bio: String) {
        self.name = name
        self.imageURL = imageURL
        self.bio = bio
    }
    
}
