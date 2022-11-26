//
//  ContentView.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 08/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DataServiceViewModel()

    var body: some View {
      
        if (viewModel.isLoading){
            ProgressView()
        } else {
            NavigationView {
                ScrollView {
//                              GeometryReader { proxy in
//                                Rectangle()
//                                .frame(width: 0, height: 0)
//                                .onChange(of: proxy.frame(in: .global).midY) { newValue in
//
//                                    if(newValue == -1842.0){
//                                        viewModel.loadMoreContent()
//
//                                    }
//                                    print(newValue)
//                                }
//                              }
                        
                    LazyVStack (alignment: .trailing, spacing: 20){
                        ForEach((viewModel.photo)) { post in
                            NavigationLink(destination: DetailView( user: post.user, photoId: post ), label: {
                                PhotoListView(photoStruct: post)
                                   
                            })
                            .accentColor(.black.opacity(0.7))
                            .onAppear(){
                                
                                if(!viewModel.fetching){
                                    print("NOT FECTHING")
                                    viewModel.loadMoreContent(photos: post)
                                    
                                }
                                
                            }

                        }
                    }
                    .padding(.all, 20)
                    .overlay(alignment: .bottom, content: {
                        ProgressView()
                        
                    })
                }
                .navigationTitle("Unsplash")
                
                
            
            }
            .onAppear(perform: {
                viewModel.getData()
            })

        }
        
 
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







//private extension ContentView{
//
//
//    var userImage : some View{
//        AsyncImage(url: URL(string: post.user?.profile_image?.medium ?? "")) { returnedImg in
//                returnedImg
//                .clipShape(Circle())
//            } placeholder: {
//                ProgressView()
//        }
//
//    }
//
//}

struct PhotoListView: View {
    let photoStruct : PhotoStruct
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 30) {
                AsyncImage(url: URL(string: photoStruct.user?.profile_image?.medium ?? "")) { returnedImg in
                    returnedImg
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(photoStruct.user?.first_name ?? "")
                    Text(photoStruct.user?.username ?? "")
                        .foregroundColor(.gray.opacity(0.7))
                }
                Spacer()
                
            }
          
            AsyncImage(url: URL(string: photoStruct.urls?.regular ?? "")) { returnedImg in
                returnedImg
                    .resizable()
                    .frame(width: 300.0, height: 250.0)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
            } placeholder: {
                ProgressView()
            }
            
        }
        .padding()
        .background(.gray.opacity(0.1), in: Rectangle())
        .cornerRadius(10.0)
    }
}



