//
//  LoadingPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 26/10/2020.
//

import Foundation
import SwiftUI

struct LoadingView : View {
    @EnvironmentObject var dataHandler : DataHandler

    @State var isLoggeIn : Bool = false
    @State var isLoaded : Bool = false
    
    var body: some View {
        Group{
            if isLoaded == false {
                Text("InstaTraining").bold().font(.largeTitle)
            } else {
                if isLoggeIn == true {
                    TabViewController(dataHandler: dataHandler, isLoggedIn: self.$isLoggeIn)
                } else {
                    LoginPage(isLoggedIn: self.$isLoggeIn)
                }
            }
                            
                        
        }.onAppear() {
            self.dataHandler.checkIfLoggedIn(completion: {
                            islog in
                            if islog {
                                self.isLoggeIn = true
                            } else {
                                self.isLoggeIn = false
                            }
                            self.isLoaded = true
                        })
        }
    }
}
