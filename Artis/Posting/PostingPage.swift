//
//  PostingPage.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI
import RealmSwift
import Firebase

struct PostingView : View {
    
    @ObservedObject var dataHandler : DataHandler
    
    @State private var description = String()
    @State private var isPresented  : Bool = false
    @State private var image        : Image?
    @State private var uiImage      : UIImage?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    if image != nil {
                        self.image!.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().cornerRadius(5)
                    } else {
                        Image(systemName: "folder.circle.fill").aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().background(Color.gray).cornerRadius(5)
                    }
                    Spacer()
                    Button(action: self.choosePhoto, label: {
                        Text("Choose Photo")
                    })
                    Spacer()
                }.padding()
                
                Text("Description").font(.largeTitle).bold()
                Text("Type your thoughts").font(.caption).foregroundColor(.gray)
                MultilineTextView(text: self.$description).cornerRadius(5).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
            }.padding()
            Spacer()
            Button(action: self.submit, label: {
                Text("Submit").bold().frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center).foregroundColor(.white).background(Color.blue).cornerRadius(10).padding()
            })
        }.sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        })
        
    }
    
    func choosePhoto(){
        self.isPresented.toggle()
    }
    
    func submit(){
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else {return}
        
        let postId = UUID().uuidString
        
        let ref = Storage.storage().reference().child("posts").child(postId)
        
        ref.putData( imageData, metadata: nil, completion: {
            (metadata, error) in
            if error == nil {
                ref.downloadURL { (url, error) in
                    if error == nil {
                        
                        let imageHeight = self.uiImage?.size.height ?? 0
                        let imageWidth = self.uiImage?.size.width ?? 0
                        let aspectRatio = Double(imageHeight/imageWidth)
                        
                        var searchTerm = [String : Bool]()
                        for word in self.description.components(separatedBy: " ") {
                            searchTerm[word.lowercased()] = true
                        }
                        
                        Database.database().reference().child("posts").child(postId).updateChildValues(["imageUrl" : url?.absoluteString ?? "",
                                                                                                        "id" : postId,
                                                                                                        "comment" : self.description,
                                                                                                        "aspectRatio" : aspectRatio,
                                                                                                        "searchTerm" : searchTerm,
                                                                                                        "date": Date().iso8601])
                    }
                }
            } else {
                print(error!)
            }
        })
    }
}

