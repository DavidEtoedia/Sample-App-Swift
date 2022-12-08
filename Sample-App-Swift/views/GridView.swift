//
//  GridView.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 28/11/2022.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                Rectangle()
                Rectangle()
                Rectangle()
                Rectangle()
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
