//
//  IGTRealmObject.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 19/10/2020.
//

import Foundation
import RealmSwift

extension Object {
    func writeToRealm() {
        try! uiRealm.write({
            uiRealm.add(self, update: .all)
        })
    }
    
    func updateToRealm() {
        try! uiRealm.write({
            uiRealm.add(self, update: .modified)
        })
    }
}
