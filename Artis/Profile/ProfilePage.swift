//
//  ProfilePage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct ProfileView : View {
    @Binding var isLoggedIn : Bool
    @ObservedObject var dataHandler : DataHandler
    var body: some View {
        NavigationView{
            VStack{
                ProfileViewHeader()
//                QGrid(exempleData, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: {
//                        post in
//                    NavigationLink(
//                        destination: SinglePostView(),
//                        label: {
//                            post.image.resizable().aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width / 3 , height: UIScreen.main.bounds.width / 3, alignment: .center).clipped()
//                        })
//                })
            }.navigationBarItems(trailing: NavigationLink(
                                    destination: SettingView(isLoggedIn: self.$isLoggedIn),
                                    label: {
                                        Image(systemName: "gearshape").accentColor(.primary)
                                    })).navigationBarTitle("Profile", displayMode: .inline)
        }
       
    }

}

