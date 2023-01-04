//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yerdaulet Ismanaliyev on 05.01.2023.
//

import SwiftUI


struct ContentView: View {
    @State private var systemMove = Int.random(in: 0...2)
    @State private var totalScore = 0
    @State private var rockPaperScissors = ["🪨", "🧻", "✂️"]
    @State private var correctMove = 0
    @State private var winOrLose = false
    @State private var showScore = false
    @State private var round = 0

    var body: some View {
        ZStack{
            LinearGradient(colors: [.purple, .black, .black, .black, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Group{
                    Spacer()
                    Spacer()
                    Text("Your score is \(totalScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.heavy))
                    HStack{
                        Text("I chose ")
                            .foregroundColor(.white)
                            .font(.title.weight(.heavy))
                        Text("\(rockPaperScissors[systemMove])")
                            .font(.system(size: 50))
                    }
                    .padding()
                }
                winOrLose ?
                Text("You gotta win:")
                    .foregroundColor(.white)
                    .font(.title.weight(.heavy)) :
                Text("You gotta lose:")
                    .foregroundColor(.white)
                    .font(.title.weight(.heavy))
                HStack(spacing: 15) {
                    ForEach(0..<3){number in
                        Button{
                            moveMade(number)
                        } label: {
                            Text("\(rockPaperScissors[number])")
                                .font(.system(size: 100))
                        }
                    }
                }
                .padding()
                Spacer()
                Spacer()
            }
        }
        .alert(Text("Game is finished"), isPresented: $showScore){
            Button("Again", action: nextRound)
        }message: {
            Text("Your score is \(totalScore)")
        }
    }
    func moveMade(_ number: Int){
        findCorrectMove(systemMove, winOrLose)
        if number == correctMove{
            totalScore += 1
        }else{
            totalScore -= 1
        }
        round += 1
        if round == 10 {
            showScore = true
        }
        winOrLose.toggle()
        systemMove = Int.random(in: 0..<3)
    }
    func nextRound(){
        round = 0
        totalScore = 0
        winOrLose.toggle()
        systemMove = Int.random(in: 0..<3)
    }
    func findCorrectMove(_ systemMove: Int, _ winOrLose: Bool){
        if winOrLose {
            if systemMove != 2{
                correctMove = systemMove + 1
            }else{
                correctMove = 0
            }
        }else{
            if systemMove != 0{
                correctMove = systemMove - 1
            }else{
                correctMove = 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
