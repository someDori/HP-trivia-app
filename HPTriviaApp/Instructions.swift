//
//  Instructions.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 11.12.24.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                
                ScrollView {
                    Text("How to play")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Welcome to HP trivia! In this game you will be asked random questions from the HP books. You must guess the right answer or you'll lose some points!😱")
                        
                        Text("Each question is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                            
                        Text("If you are struggling with a question, there is an option to reveal a hint or the book that answers the right question. But beware! Using these also minuses 1 point each.")
                            
                        Text("When you select the correct answer, you will be awarded all the points left for that question and they will be added to your total score")
                    }
                    .padding(.horizontal)
                    .font(.title2)
                    
                    Text("Good Luck!")
                        .font(.title)
                }
                .foregroundStyle(.black)
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Instructions()
}
