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
    let photo : PhotoStruct?
    let column : [GridItem] = [
        GridItem(.fixed(50), spacing: 30),
        GridItem(.fixed(50), spacing: 30),
        GridItem(.fixed(50), spacing: 30),
        GridItem(.fixed(50), spacing: 30)
    ]
    

    var body: some View {
       
            ScrollView {
                VStack (alignment: .leading){
                    HStack {
                    ProfileImageView(userImageUrl: user?.profile_image?.medium)
                        VStack(alignment: .leading, spacing: 4 ) {
                            Text(user?.name ?? "" )
                                .font(.system(size: 20, weight: .medium))
                            Text(user?.location ?? "Unknown")
                                .font(.system(.subheadline, weight: .medium))
                                .foregroundColor(.gray.opacity(0.6))
                        }
                        Spacer()

                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach( viewModel.photosDetails?.related_collections?.results ?? [] , id: \.id ) { related in
                                        ForEach((related.preview_photos ?? []) ) { resultV in
                                            GeometryReader { geometry in
                                                ExtractedView(url: resultV.urls?.regular)
                                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX)), axis: (x: 20.0, y: 8.0, z: 10.0))
       
                                            }
                                            .frame(width: 246, height: 220)
                                            .padding(.vertical, 40)
                                        }
                            }
        //                    ImageView(imageUrl: photo?.urls?.regular)
                        }
                        .padding(.horizontal, 60)
//                      .frame(width: UIScreen.main.bounds.size.width, height: 300)
                    }
                    Spacer(minLength: 20)
                    HStack ( spacing: 10){
                        Text("Likes:")
                            .foregroundColor(.gray.opacity(0.8))
                        Text(viewModel.photosDetails?.likes?.description ?? "0")
                        Spacer(minLength: 5)
                        Text("Downloads:")
                            .foregroundColor(.gray.opacity(0.8))
                        Text(viewModel.photosDetails?.downloads?.description ?? "0")
                    }
                    .padding(.horizontal, 50)
                   Spacer(minLength: 40)
                    Text("Related Collections")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 50)
                    Spacer(minLength: 40)

                        ForEach( viewModel.photosDetails?.related_collections?.results ?? [] , id: \.id ) { related in
                               LazyVGrid(columns: column) {
                                    ForEach((related.preview_photos ?? []) ) { resultV in
                                        AsyncImage(url: URL(string: resultV.urls?.small ?? "")) { returnedImg in
                                            returnedImg
                                                .resizable()
                                                .frame(width: 75.0, height: 75.0)
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(RoundedRectangle(cornerRadius: 6.0))
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .padding(.all, 20)
                                        }

                                    }
                                    
                                }

                        }

                }
                .onAppear(perform: {viewModel.getUserDetails(id: photo?.id ?? "")
                }
            )
            }
            .navigationBarTitleDisplayMode(.inline)

    }
    
       
}
        

//struct DetailView_Previews: PreviewProvider {
//    let user = User(to: <#T##Encoder#>)
//    static var previews: some View {
//        DetailView(user: <#User?#>, photo: <#PhotoStruct?#>)
//    }
//}



struct ExtractedView: View {
    let url : String?
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { returnedImg in
            returnedImg
                .resizable()
                .frame(width: 300.0, height: 200.0)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))
            
        }
        
    placeholder: {
        ProgressView()
            .padding(.all, 20)
    }
    }
}
