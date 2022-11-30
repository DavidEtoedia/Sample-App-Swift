//
//  ContentView.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 08/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DataServiceViewModel()
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero


    var body: some View {
      
        if (viewModel.isLoading){
            ProgressView()
        } else {
            NavigationView {
                ChildSizeReader(size: $wholeSize) {
                    ScrollView {
                        ChildSizeReader(size: $scrollViewSize) {
                            VStack (alignment: .leading, spacing: 20){
                                ForEach((viewModel.photo)) { photo in
                                    NavigationLink(destination: DetailView( user: photo.user, photo: photo ), label: {
                                        PhotoListView(photoStruct: photo)
                                           
                                    })
                                    .accentColor(.black.opacity(0.7))
                                  
                                  

                                }

                            }
                            .padding(.all, 20)
                            .background(
                      GeometryReader { proxy in
                         Color.clear.preference(
                                key: ViewOffsetKey.self,
                                    value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                                       )
                                                   }
                                               )
                            .onPreferenceChange(
                                ViewOffsetKey.self,
                                perform: { value in
                                    print("offset: \(value)") // offset: 1270.3333333333333 when User has reached the bottom
                                    print("scroll-height: \(scrollViewSize.height)") // height: 2033.3333333333333
                                    //let newvalue : Double = 500.5
                                    let sum = (scrollViewSize.height - wholeSize.height)
                                    let newSum = Int(sum)
                                    print("SUM: \(newSum)")
                                
                                    
                                     
                                    if newSum == Int(value) {
                                        print(true)
                                        print(viewModel.fetching)
                                        print("FETCHING: \(viewModel.fetching)")
                                        if (viewModel.fetching){
                                            print("yes OHHHHHHHHHHHHHH")
                                            return
                                        } else{
                                            viewModel.loadMoreContent()

                                        }
                                       
                                    }
 
                                }
                            )
                        
                            .overlay(alignment: .bottom, content: {
                                ProgressView()
                                    .padding(.vertical, 0)
 
                        })
                             
                        }
                        
                    }
                    .coordinateSpace(name: spaceName)
                    .navigationBarTitle("Unsplash", displayMode: .large)
                  
                }
                
            }
            .onAppear(perform: {
               viewModel.getData()
                print("view-state: \(viewModel.isLoading)")
//                Task{
//                    await viewModel.getImages()
//                }
             
            })

        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct ViewOffsetKey: PreferenceKey {
  typealias Value = CGFloat
  static var defaultValue = CGFloat.zero
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

struct ChildSizeReader<Content: View>: View {
  @Binding var size: CGSize

  let content: () -> Content
  var body: some View {
    ZStack {
      content().background(
        GeometryReader { proxy in
          Color.clear.preference(
            key: SizePreferenceKey.self,
            value: proxy.size
          )
        }
      )
    }
    .onPreferenceChange(SizePreferenceKey.self) { preferences in
      self.size = preferences
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}


struct PhotoListView: View {
    let photoStruct : PhotoStruct
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 30) {
                ProfileImageView(userImageUrl: photoStruct.user?.profile_image?.medium)
                VStack(alignment: .leading) {
                    Text(photoStruct.user?.first_name ?? "")
                        .font(.system(size: 20, weight: .medium))
                    Text(photoStruct.user?.username ?? "")
                        .foregroundColor(.gray.opacity(0.7))
                }
                Spacer()
            }
          
            ImageView(imageUrl: photoStruct.urls?.regular)
            
        }
        .padding()
        .background(.gray.opacity(0.1), in: Rectangle())
        .cornerRadius(10.0)
    }
}




struct ProfileImageView: View {
    
    let userImageUrl : String?
    var body: some View {
        AsyncImage(url: URL(string: userImageUrl ?? "")) { returnedImg in
            returnedImg
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
    }
}
struct ImageView: View {
    let imageUrl : String?
    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { returnedImg in
            returnedImg
                .resizable()
                .frame(width: 300.0, height: 250.0)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
        } placeholder: {
            ProgressView()
                .padding(.all, 70)
        }
    }
}
