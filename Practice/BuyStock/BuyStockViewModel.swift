//
//  BuyStockViewModel.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-05.
//

import Foundation
import Combine

enum BuyState {
    case prep
    case executing
    case executed
    case cancelled
}

class BuyStockViewModel: ObservableObject {
    
    @Published var state: BuyState = .prep
    
    init() {
        print("BuyStock VM Init")
    }
    
    deinit {
        print("BuyStock VM Killed")
    }
    
    public func buyStock() {
        state = .executing
        Task {
            let _ = await mockAPICall()
            guard state != .cancelled else {
                return
            }
            DispatchQueue.main.async {
                self.state = .executed
            }
        }
    }
    
    public func cancel() {
        state = .cancelled
    }
    
    private func mockAPICall() async -> String {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        return "Stock is bought"
    }
}
