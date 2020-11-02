//
//  SettingPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI
import Firebase
import RealmSwift

struct SettingView : View {
    
    @State private var username     = String()
    
    @State private var image        : Image?
    @State private var uiImage      : UIImage?
    @State private var isPresented  : Bool = false
    
    @Binding var isLoggedIn         : Bool
    
    var body: some View {
        VStack{
            HStack{
                if image != nil {
                    self.image!.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().cornerRadius(40)
                } else {
                    Image(systemName: "folder.circle.fill").aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().background(Color.gray).cornerRadius(40)
                }
                Spacer()
                Button(action: self.choosePhoto, label: {
                    Text("Choose Photo")
                })
                Spacer()
            }.padding()
            TextField("Username", text: self.$username, onEditingChanged: {
                changed in
            }, onCommit: {
                self.submitNewUsername()
            }).padding()
            Button(action: self.submit, label: {
                Text("Submit").bold().frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center).foregroundColor(.white).background(Color.blue).cornerRadius(10).padding()
            })
            Spacer()
            Button(action: self.logout, label: {
                Text("Logout").bold().frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center).foregroundColor(.white).background(Color.red).cornerRadius(10).padding()
            })
        }.sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        })
        
        
    }
    
    func submitNewUsername(){
        if username == "" {
            
        } else {
            
        }
    }
    
    func choosePhoto(){
        self.isPresented.toggle()
    }
    
    func submit(){
        
    }
    
    func logout(){
        self.isLoggedIn = false
        try! Auth.auth().signOut()
        try! uiRealm.write({
            uiRealm.deleteAll()
        })
        
        
    }
}
