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
            HStack {
                NavigationLink {
                    BuyStock()
                } label: {
                    Text("Buy Stock")
                        .modifier(MyButtonModifier())
                }
                
                NavigationLink {
                    BuyStock()
                } label: {
                    Text("API List")
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
