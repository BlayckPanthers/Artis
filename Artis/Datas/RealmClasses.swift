//
//  RealmClasses.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 19/10/2020.
//

import Foundation
import RealmSwift

class PostObject : Object {
    @objc dynamic var id        : String        = ""
    @objc dynamic var imageUrl  : String        = ""
    @objc dynamic var comments  : String        = ""
    @objc dynamic var aspectRto : Double        = 0
    @objc dynamic var date      : Date?          = nil
    @objc dynamic var user      : UserObject?   = nil
    
    var isLiked = RealmOptional<Bool>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}

class UserObject : Object {
    @objc dynamic var id                : String = ""
    @objc dynamic var username          : String = ""
    @objc dynamic var profileImageUrl   : String = ""
    
    var isLoggedIn  = RealmOptional<Bool>()
    var isFollowing = RealmOptional<Bool>()
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

