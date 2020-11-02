//
//  PostCell.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct PostCell : View {
    var currentPost : PostObject
    
    @Environment (\.imageCache) var cache : ImageCache
    var body: some View {
        VStack {
            if URL(string: currentPost.imageUrl) != nil {
                AsyncImage(url: URL(string: self.currentPost.imageUrl)!, placeholder: { Color.gray } , image:{ Image(uiImage: $0).resizable()}).frame(height: (UIScreen.main.bounds.width - 20) * CGFloat(self.currentPost.aspectRto), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            }
            HStack {
                Image("img2").resizable().frame(width: 50, height: 50, alignment: .center).cornerRadius(25)
                VStack(alignment: .leading) {
                    Text("Fabien Lebon")
                    Text(currentPost.date?.formatdate() ?? "").font(.caption).foregroundColor(.gray)
                }
                Spacer()
            }.padding()
            Divider().padding(.horizontal)
            Text(currentPost.comments).lineLimit(nil).padding().frame(maxWidth: .infinity, alignment: .leading)
        }.cornerRadius(20).shadow(radius: 10).padding()
    }
}

