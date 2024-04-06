//
//  ExecutingView.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import SwiftUI

struct ExecutingView: View {
    //@ObservedObject var vm: BuyStockViewModel
    
    var body: some View {
        ZStack {
            Color.blue
            Text("Purchasing in progress...")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}
