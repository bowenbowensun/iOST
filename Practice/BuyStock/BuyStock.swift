//
//  Play1.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-02.
//

import SwiftUI

struct BuyStock: View {
    
    @StateObject var vm = BuyStockViewModel()
    
    var body: some View {
        Group {
            switch vm.state {
            case .prep:
                SubmitView(vm: vm)
            case .executing:
                ExecutingView()
            case .executed:
                ExecutedView()
            case .cancelled:
                FailureView()
            }
        }
        .animation(.easeIn, value: vm.state)
        .ignoresSafeArea(edges: .top)
    }
}


#Preview {
    BuyStock()
}
