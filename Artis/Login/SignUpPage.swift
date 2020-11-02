//
//  SignUpPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI
import Firebase

struct SignUpView : View {
    @State private var email = String()
    @State private var password = String()
    @State private var username = String()
    @State private var passwordRe = String()
    
    @Binding var isPresented : Bool
    
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View{
        NavigationView{
            Form{
                Spacer()
                Section{
                    TextField("Email",              text : self.$email).frame(height: 60, alignment: .center)
                    TextField("Username",           text : self.$username).frame(height: 60, alignment: .center)
                    SecureField("password",         text : self.$password).frame(height: 60, alignment: .center)
                    SecureField("password (again)",  text : self.$passwordRe).frame(height: 60, alignment: .center)
                }
                Spacer()
                Section {
                    Button(action: self.submit, label: {
                        Text("Submit").bold().frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center).foregroundColor(.white).background(Color.blue).cornerRadius(10).padding()
                    })
                }
                
            }.navigationBarTitle("Sign Up", displayMode: .large)
        }
    }
    
    func submit(){
        self.isPresented.toggle()
        
        if self.password == self.passwordRe {
            Auth.auth().createUser(withEmail: self.email, password: self.password, completion: {
                (result, error) in
                if error == nil {
                    let user = UserObject()
                    user.id = result?.user.uid ?? ""
                    user.username = self.username
                    user.isLoggedIn.value = true
                    user.writeToRealm()
                    
                    let ref = Database.database().reference().child("users")
                    
                    ref.child(user.id).updateChildValues(["uid": user.id,
                                                          "username": self.username])
                } else {
                    print(error!)
                }
            })
        }
        
    }
}


struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isPresented: .constant(false))
    }
}
