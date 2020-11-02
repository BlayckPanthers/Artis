//
//  TabViewController.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct TabViewController : View {
    @ObservedObject var dataHandler : DataHandler
    @Binding var isLoggedIn : Bool
    
    var body: some View {
        TabView{
            HomeView(dataHandler: dataHandler).tabItem ({ Image(systemName: "house.fill") })
            ExploreView(dataHandler: dataHandler).tabItem ({ Image(systemName: "magnifyingglass.circle.fill")})
            PostingView(dataHandler: dataHandler).tabItem ({ Image(systemName: "plus.app.fill")})
            NotificationView(dataHandler: dataHandler).tabItem ({ Image(systemName: "bolt.circle.fill") })
            ProfileView(isLoggedIn: self.$isLoggedIn, dataHandler: dataHandler).tabItem ({ Image(systemName: "person.circle.fill") })
        }
        
        
    }
    
    
}
