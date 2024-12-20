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
    @Published var purchasedIDs = Set<String>()
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    private var updates: Task<Void, Never>? = nil
    
    init() {
        updates = watchForUpdates()
    }
    
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("There was an error on \(signedType): \(verificationError)")
                    break
                    
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                
            case .userCancelled, .pending:
                break
                
            @unknown default:
                break
            }
        } catch {
            print("Couldn't purchase: \(error)")
        }
    }
    
    func checkPurchased() async {
        for product in products {
            guard let state = await product.currentEntitlement else {
                return
            }
            
            switch state {
            case .unverified(let signedType, let verificationError):
                print("There was an error on \(signedType): \(verificationError)")
            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)
                } else {
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    
    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
}
