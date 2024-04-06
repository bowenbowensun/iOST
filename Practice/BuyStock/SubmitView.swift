//
//  SubmitView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-06.
//

import SwiftUI

struct SubmitView: View {
    @ObservedObject var vm: BuyStockViewModel
    @State private var yOffset: CGFloat = 0
    @State private var ready = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if ready {
                    Color.blue
                    OrderView(vm: vm)
                        .offset(x: 0, y: yOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    yOffset = value.translation.height
                                })
                                .onEnded({ value in
                                    if abs(yOffset) > proxy.size.height / 2 {
                                        withAnimation {
                                            yOffset = -1 * proxy.size.height
                                        } completion: {
                                            vm.buyStock()
                                        }

                                    } else {
                                        yOffset = 0
                                    }
                                })
                        )
                        .animation(.easeIn, value: yOffset)
                } else {
                    ReadyView(ready: $ready)
                }
            }
            .animation(.easeIn, value: ready)
        }
    }
}

private struct ReadyView: View {
    @Binding var ready: Bool
    var body: some View {
        ZStack {
            Color.white
            Button {
                ready = true
            } label: {
                Text("Ready")
                    .modifier(MyButtonModifier())
            }
        }
        
    }
}

private struct OrderView: View {
    @ObservedObject var vm: BuyStockViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.white
                Text("AMZN")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
            }
            .clipShape(.rect(bottomLeadingRadius: 20, bottomTrailingRadius: 20))
            VStack {
                Image(systemName: "arrowshape.up.fill")
                Text("Submit order")
                    .bold()
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}
