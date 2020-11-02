//
//  HomePage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct HomeView : View {
    
    @ObservedObject var dataHandler : DataHandler
    var body: some View {
        NavigationView {
            List{
                ForEach(self.dataHandler.homePagePost, id: \.self, content: {
                        post in
                        PostCell(currentPost: post).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    })
                
            }.navigationBarBackButtonHidden(true).navigationBarTitle("Home", displayMode: .inline)
        }
    }
}
