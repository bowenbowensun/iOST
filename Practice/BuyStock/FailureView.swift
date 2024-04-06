//
//  FailureView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import SwiftUI

struct FailureView: View {
    var body: some View {
        ZStack {
            Color.red
            Text("Failed / Cancelled")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    FailureView()
}
