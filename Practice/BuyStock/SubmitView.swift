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
                Color.blue
                OrderView(vm: vm, ready: $ready)
                    .offset(x: 0, y: yOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                guard ready && value.translation.height < 0 else {
                                    return
                                }
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
                    .transition(.offset(x: 0, y: 40))
            }
        }
    }
}

private struct OrderView: View {
    @ObservedObject var vm: BuyStockViewModel
    @Binding var ready: Bool
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
            }
        }
        .animation(.easeIn, value: ready)
    }
}
