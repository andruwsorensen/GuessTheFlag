//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andruw Sorensen on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var roundComplete = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var flagSelected = ""
    @State private var currentRound = 1
    @State private var totalRounds = 8
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.27),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.15), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule(style: .continuous))
                                .shadow(radius: 15)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("\(currentRound) of \(totalRounds)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("You selected \(flagSelected)")
        }
        .alert("Round Complete", isPresented: $roundComplete) {
            Button("Play Again", action: reset)
        } message: {
            Text("You got \(currentScore) correct of \(totalRounds)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        flagSelected = countries[number]
        showingScore = true
        if currentRound >= totalRounds {
            roundComplete = true
        } else {
            currentRound += 1
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        currentRound = 1
        currentScore = 0
    }
}

#Preview {
    ContentView()
}
