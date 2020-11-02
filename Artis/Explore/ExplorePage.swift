//
//  ExplorePage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI


struct ExploreView : View {
    @ObservedObject var dataHandler : DataHandler
    @State private var isSearching : Bool = false
    @State private var searchText = String()
    
    @Environment (\.imageCache) var cache : ImageCache
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search ...", text: self.$searchText, onEditingChanged: {
                    changed in
                }, onCommit: {
                    self.search()
                }).padding()
                if isSearching == true {
                    List {
                        ForEach(self.dataHandler.searchPost, id: \.id, content: {
                            post in
                            PostCell(currentPost: post).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        })
                    }
                } else {
                    QGrid(self.dataHandler.explorePagePost, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: {
                            post in
                        NavigationLink(
                            destination: SinglePostView(currentPost: post.post),
                            label: {
                                AsyncImage(url: URL(string: post.post.imageUrl)!, placeholder: { Color.gray } , image:{ Image(uiImage: $0).resizable()}).aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width / 3 , height: UIScreen.main.bounds.width / 3, alignment: .center).clipped()
                            })
                    })
                }
            }.navigationBarTitle("Explore", displayMode: .inline)
        }
    }
    
    func search(){
        if self.searchText ==  "" {
            self.isSearching = false
        } else {
            self.isSearching = true
            self.dataHandler.loadPostsFrom(self.searchText.lowercased())
        }
    }
}


struct PostIdentifiable : Identifiable {
    var id = UUID()
    var post : PostObject
}
