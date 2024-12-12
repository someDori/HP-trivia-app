//
//  InfoBackgroundImage.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 12.12.24.
//

import SwiftUI

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}
