//
//  Movies.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import SwiftUI

struct Movies: View {
    @StateObject var vm = MovieViewModel()
    var body: some View {
        Button {
            vm.catFactNativeAsync()
        } label: {
            Text("Test API")
                .modifier(MyButtonModifier())
        }
        List(vm.displayableCat) { cat in
            HStack {
                AsyncImage(url: cat.imgUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 10)
                        
                } placeholder: {
                    ProgressView()
                }
                Text(cat.text)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    Movies()
}
