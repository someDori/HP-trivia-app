//
//  Store.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 13.12.24.
//

import Foundation
import StoreKit

@MainActor
class Store: ObservableObject {    
    @Published var books: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]    
    @Published var products: [Product] = []
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch products: \(error)")
        }
    }
}
