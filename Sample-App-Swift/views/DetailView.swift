//
//  DetailView.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 18/11/2022.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel = DataServiceViewModel()
    let user : User?
    let photoId : PhotoStruct?
    

    var body: some View {
        VStack {
//            Text()
            Text(user?.first_name ?? "")
               
        }
        .onAppear(perform: {viewModel.getUserDetails(id: photoId?.id ?? "")
            print(user?.id ?? "")
            
        }
    
        )
    }
       
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(, photoDetail: PhotoDetails())
//    }
//}
