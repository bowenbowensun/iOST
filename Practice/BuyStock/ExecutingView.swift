//
//  ExecutingView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import SwiftUI

struct ExecutingView: View {
    //@ObservedObject var vm: BuyStockViewModel
    
    @State private var animating = false
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .fill(.white)
                    .frame(width: 200)
                    .rotationEffect(animating ? .degrees(360) : .zero)
                    .animation(
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: animating
                    )
                    
                Text("Purchasing in progress...")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.top)
            }
        }
        .onAppear(perform: {
            animating = true
        })
    }
}

#Preview {
    ExecutingView()
}
