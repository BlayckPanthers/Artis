//
//  SinglePost.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct SinglePostView : View {
    var currentPost : PostObject
    
    var body: some View {
        ScrollView{
            PostCell(currentPost: currentPost).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
