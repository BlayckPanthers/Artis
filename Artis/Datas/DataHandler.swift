//
//  DataHandler.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 19/10/2020.
//

import Foundation
import SwiftUI
import Firebase
import RealmSwift

class DataHandler : ObservableObject {
    @Published var homePagePost = [PostObject]()
    @Published var explorePagePost = [PostIdentifiable]()
    @Published var searchPost = [PostObject]()
    @Published var loggedInUser = UserObject()
    
    init(){
        self.loadHomePagePosts()
        self.loadExplorePagePost()
        
    }
    
    func loadHomePagePosts() {
       
        let ref = Database.database().reference()
        ref.child("posts").observe(.value, with: {
            snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject] else {return}
                self.homePagePost.append(handlePostDict(dict))
                self.homePagePost.sort(by: {$0.date!.compare($1.date!) == .orderedDescending})
            }
        })
    }
    
    func loadExplorePagePost() {
        let ref = Database.database().reference()
        ref.child("posts").observe(.value, with: {
            snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject] else {return}
                self.explorePagePost.append(PostIdentifiable(post:handlePostDict(dict)))
            }
        })
    }
    
    func loadPostsFrom(_ keyword : String) {
        self.searchPost.removeAll()
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild:("searchTerm/\(keyword)")).queryEqual(toValue: true).observeSingleEvent(of: .value, with: {
            snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject] else {return}
                self.searchPost.append(handlePostDict(dict))
            }
        })
    }
    
    func checkIfLoggedIn(completion : @escaping (_ isLoggedIn : Bool) -> ()){
        guard let userId = Auth.auth().currentUser?.uid else {completion(false); return}
        let uiRealm = try! Realm()
        
        if uiRealm.object(ofType: UserObject.self, forPrimaryKey: userId) != nil {
            let ref = Database.database().reference().child("users")
            ref.child(userId).observeSingleEvent(of: .value) { (snapshot) in
                guard let dict = snapshot.value as? [String : AnyObject] else {return}
                self.loggedInUser = handleUserDict(dict)
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    deinit {
        self.homePagePost.removeAll()
    }
}



func handlePostDict(_ dict : [String:AnyObject]) -> PostObject {
    let post = PostObject()
    post.id = dict["id"] as? String ?? ""
    post.comments = dict["comment"] as? String ?? ""
    post.date = (dict["date"] as? String ?? "").iso8601
    post.aspectRto = dict["aspectRatio"] as? Double ?? 1.0
    post.imageUrl = dict["imageUrl"] as? String ?? ""
    post.writeToRealm()
    return post
}

func handleUserDict(_ dict : [String:AnyObject]) -> UserObject {
    let user = UserObject()
    user.id = dict["uid"] as? String ?? ""
    user.username = dict["username"] as? String ?? ""
    user.writeToRealm()
    return user
}
