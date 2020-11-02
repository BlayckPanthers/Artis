//
//  ProfileViewHeader.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 15/10/2020.
//

import Foundation
import SwiftUI

struct ProfileViewHeader : View {
    var body: some View {
        HStack{
            VStack{
                Image("img2").resizable().frame(width: 80, height: 80, alignment: .center).cornerRadius(40)
                Text("My NAME").bold().font(.footnote)
            }
            Spacer()
            VStack{
                Text("Followers").font(.callout)
                Text("1003").font(.caption).bold()
            }
            Spacer()
            VStack{
                Text("Following").font(.callout)
                Text("679").font(.caption).bold()
            }
            Spacer()
        }.padding()
    }
}

struct ProfileViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewHeader()
    }
}
