//
//  Movies.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import SwiftUI

struct Movies: View {
    @StateObject var vm = MovieViewModel()
    @State private var isOn = false
    var body: some View {
        HStack {
            Button {
                vm.catFactNativeAsync()
            } label: {
                Text("Test API")
                    .modifier(MyButtonModifier())
            }
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .background(Color.red)
        ZStack {
            Color.blue
            List(vm.displayableCat) { cat in
                CatCell(catVM: cat)
            }
            .listStyle(.plain)
            .background(Color.green)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: 200, height: 50)
                    .cornerRadius(20)
            }
        }
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
