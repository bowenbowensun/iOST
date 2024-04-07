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
    @State private var textOpacity: CGFloat = 1
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.blue
                OrderView(vm: vm, ready: $ready, textOpacity: $textOpacity)
                    .offset(x: 0, y: yOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                guard ready && value.translation.height < 0 else {
                                    return
                                }
                                yOffset = value.translation.height
                                let frameHeight = proxy.size.height
                                if abs(yOffset) < frameHeight / 2 {
                                    textOpacity = 1 - abs(yOffset) / (frameHeight / 2)
                                } else {
                                    textOpacity = 0
                                }
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
                                    textOpacity = 1
                                }
                            })
                    )
                    .animation(.easeIn, value: yOffset)
                    .transition(.offset(x: 0, y: 40))
            }
        }
    }
}

private struct OrderView: View {
    @ObservedObject var vm: BuyStockViewModel
    @Binding var ready: Bool
    @Binding var textOpacity: CGFloat
    var body: some View {
        VStack {
            ZStack {
                Color.white
                if ready {
                    Text("AMZN")
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                } else {
                    Button {
                        ready = true
                    } label: {
                        Text("Ready")
                            .modifier(MyButtonModifier())
                    }
                }
            }
            .clipShape(.rect(bottomLeadingRadius: ready ? 20 : 0, bottomTrailingRadius: ready ? 20 : 0))
            if ready {
                VStack {
                    Image(systemName: "arrowshape.up.fill")
                    Text("Submit order")
                        .bold()
                }
                .foregroundStyle(.white)
                .padding()
                .opacity(textOpacity)
            }
        }
        .animation(.easeIn, value: ready)
    }
}
