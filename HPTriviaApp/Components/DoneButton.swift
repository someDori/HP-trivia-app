//
//  DoneButton.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 12.12.24.
//

import SwiftUI

extension Button {
    func doneButton() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundStyle(.white)
    }
}
