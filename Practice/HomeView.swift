//
//  HomeView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-02.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    BuyStock()
                } label: {
                    Text("Buy Stock")
                        .modifier(MyButtonModifier())
                }
                
                NavigationLink {
                    Movies()
                } label: {
                    Text("API List")
                        .modifier(MyButtonModifier())
                }
                
                NavigationLink {
                    MovePosition()
                } label: {
                    Text("Move Animate")
                        .modifier(MyButtonModifier())
                }

            }
        }
    }
}

struct MyButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(Color.orange)
            .fontWeight(.bold)
            .cornerRadius(10)
    }
}

#Preview {
    HomeView()
}
