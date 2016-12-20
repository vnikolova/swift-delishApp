//
//  Recipe.swift
//  RealmRecipes
//
//  Created by admin on 09/12/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import Foundation
import RealmSwift


class Recipe: Object {
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var label = ""
    dynamic var time = 0
    dynamic var imageURL = ""
    
    //set primary key
    override static func primaryKey() -> String? {
        return "id"
    }
}

