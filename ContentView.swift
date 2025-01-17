//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Prasanna Bhat on 29/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var flags = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    private static let flagsRange = (0..<3)
    @State private var correctAnswer = Int.random(in: flagsRange)
    
    // Alert Related
    @State private var displayAlertMessage = ""
    @State private var isAlertDisplayed: Bool = false
    @State private var score = 0
    private let totalGames = 8
    
    var body: some View {
        VStack {
            ZStack {
                RadialGradient(stops: [.init(color: Color("PrimaryBg"), location: 0.3),
                                       .init(color: Color("SecondaryBg"), location: 0.3)],
                               center: .top,
                               startRadius: 200,
                               endRadius: 700)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Guess the flag")
                        .font(.title.weight(.bold))
                        
                    
                    VStack(spacing: 30) {
                        VStack {
                            Text("Tap the flag of")
                                .font(.headline)
                            Text("\(flags[correctAnswer].capitalized)")
                                .font(.largeTitle.weight(.semibold))
                                .fontDesign(.monospaced)
                        }
                        
                        VStack(spacing: 10) {
                            ForEach(ContentView.flagsRange) { number in
                                Button {
                                    selectedFlag(at: number)
                                } label: {
                                    Image(flags[number])
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 5)
                                    
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Spacer()
                        Text("Score - \(score)/\(totalGames)")
                            .font(.title2.weight(.bold))
                        Spacer()
                        Button {
                            reset()
                        } label: {
                            Image(systemName: "arrow.circlepath")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                        
                }
                .padding()
                .foregroundStyle(.white)
            }
        }
        .fontDesign(.rounded)
        .alert(displayAlertMessage, isPresented: $isAlertDisplayed) {
            Button("Go to next", action: nextGame)
        }
    }
    
    private func selectedFlag(at index: Int) {
        if index == correctAnswer {
            displayAlertMessage = "Correct"
            score += 1
        } else {
            displayAlertMessage = "Wrong, this is flag of \(flags[index].capitalized)"
        }
        isAlertDisplayed = true
    }
    
    // shuffle flags
    private func nextGame() {
        flags.shuffle()
        correctAnswer = Int.random(in: ContentView.flagsRange)
    }
    
    // reset the game's value to 0
    private func reset() {
        displayAlertMessage = "Previous game score - \(score)/\(totalGames)"
        isAlertDisplayed = true
        score = 0
    }
}

#Preview {
    ContentView()
}
