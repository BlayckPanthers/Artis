//
//  NotificationPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct NotificationView : View {
    
    @ObservedObject var dataHandler : DataHandler
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    ForEach(0 ..< 20, content: {
                        i in
                        NotificationCell_like()
                    })
                }.navigationBarTitle("Notifications", displayMode: .large)
            }
        }
        
    }
}
