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
            CatCell(catVM: cat)
        }
        .listStyle(.plain)
    }
}

struct CatCell: View {
    @ObservedObject var catVM: CatViewModel
    var body: some View {
        HStack {
            AsyncImage(url: catVM.imgUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.trailing, 10)
                    
            } placeholder: {
                ProgressView()
            }
            Text(catVM.text)
        }
        .scaleEffect(catVM.tapped ? 0.8 : 1)
        .onTapGesture {
            withAnimation {
                catVM.tapped.toggle()
            }
        }
    }
}

#Preview {
    Movies()
}
