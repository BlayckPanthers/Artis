//
//  LoginPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI
import Firebase

struct LoginPage : View {
    
    @State private var email        = String()
    @State private var password     = String()
    @State private var isPresented  = false
    
    @Binding var isLoggedIn : Bool
    
    var body: some View {
        VStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.purple,.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).frame(height: 200, alignment: .top).edgesIgnoringSafeArea(.top).shadow(radius: 10)
                Text("InstagramCopy").foregroundColor(.white).bold().font(.largeTitle).padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing:     0))
            }
            TextField("email", text: self.$email).padding()
            SecureField("password", text: self.$password).padding()
            HStack{
                Text("You don't have an account ?")
                Button(action: self.signUp, label: {
                    Text("Sign up now.")
                })
            }.padding()
            Spacer()
            Button(action: self.logIn, label: {
                Text("Log In").bold().frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center).foregroundColor(.white).background(Color.blue).cornerRadius(10).padding()
            })
        }.sheet(isPresented: self.$isPresented, content: {
            SignUpView(isPresented: self.$isPresented)
        })
    }
    
    func signUp(){
        self.isPresented.toggle()
    }
    
    func logIn(){
        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: {
            (result, error) in
            if error == nil{
                let user = UserObject()
                user.id = result?.user.uid ?? ""
                user.isLoggedIn.value = true
                user.writeToRealm()
                self.isLoggedIn = true
            } else {
                print(error!)
            }
        })
    }
}
