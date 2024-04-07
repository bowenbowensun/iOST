//
//  MovePosition.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-07.
//

import SwiftUI

// Ref: https://www.hackingwithswift.com/quick-start/swiftui/how-to-synchronize-animations-from-one-view-to-another-with-matchedgeometryeffect

struct MovePosition: View {
    @Namespace private var animation
    @State private var isBig = false
    
    private var imgSz: CGFloat {
        return isBig ? 200 : 100
    }
    
    var body: some View {
        VStack {
            Toggle("", isOn: $isBig)
                .labelsHidden()
            Spacer()
            HStack {
                Rectangle()
                    .fill(isBig ? .blue : .orange)
                    .frame(width: imgSz, height: imgSz)
                    .cornerRadius(20)
                    .matchedGeometryEffect(id: "rect", in: animation)
                if !isBig {
                    Text("Text is horizontal")
                        .bold()
                        .matchedGeometryEffect(id: "text", in: animation)
                }
            }
            if isBig {
                Text("Text is vertical")
                    .bold()
                    .matchedGeometryEffect(id: "text", in: animation)
            }
            Spacer()
        }
        .animation(.easeIn, value: isBig)
    }
}

#Preview {
    MovePosition()
}
