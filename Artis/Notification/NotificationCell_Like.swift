//
//  NotificationCell-Like.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct NotificationCell_like : View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                NavigationLink(
                    destination: SinglePostView(currentPost: PostObject()),
                    label: {
                        Image("img2").resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50, alignment: .center).cornerRadius(5)
                        VStack(alignment: .leading){
                            Text("NAME AUTHOR Liked your post !").font(.callout)
                            Text("One hour ago ").font(.caption)
                        }
                    }).accentColor(.primary)
                
                
                Spacer()
            }.padding()
        }.cornerRadius(5).shadow(radius: 10)
    }
}

struct NotificationCell_Like_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell_like()
    }
}
