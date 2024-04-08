//
//  SettingsView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-02.
//

import SwiftUI

struct SettingsView: View {
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var offset: CGSize = .zero
    @State private var paused = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Text("Settings")
                    .bold()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .background(paused ? Color.red: Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .offset(offset)
                    .scaleEffect(paused ? 0.8 : 1)
                    .animation(.default, value: offset)
                    .animation(.bouncy, value: paused)
                    .onReceive(timer) { value in
                        guard !paused else {
                            return
                        }
                        offset = randOffset(frameSize: proxy.size)
                    }
                    .onTapGesture {
                        paused.toggle()
                    }
            }
        }
    }
    
    private func randOffset(frameSize: CGSize) -> CGSize {
        let randomWidth = CGFloat.random(in: -0.5...0.5) * (frameSize.width - 100)
        let randomHeight = CGFloat.random(in: -0.5...0.5) * (frameSize.height - 100)
        return CGSize(width: randomWidth, height: randomHeight)
    }
}

#Preview {
    SettingsView()
}
