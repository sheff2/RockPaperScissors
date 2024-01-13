//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shaun Heffernan on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    var moves = ["🪨", "📄", "✂️"]
    var loses = ["🪨": "✂️",
                 "📄": "🪨",
                 "✂️": "📄"]
    @State var computerChoice = ["🪨", "📄", "✂️"].randomElement() ?? "🪨"
    @State var winBool = Bool.random()
    @State var showingAlert = false
    @State var userScore = 0
    @State var alertMessage = ""
    @State var currentRound = 1
    @State var roundOver = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0),
                .init(color: Color(red: 0.5, green: 0, blue: 0), location: 0.9)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
        VStack {
            Spacer()
            VStack{
                Text("Player should \(winBool ? "win" : "lose")")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(5)
                Text("Rock Paper Scissors")
                    .font(.body.bold())
                .foregroundStyle(.white)
                
            }
            
            Spacer()
            Spacer()
            VStack{
                VStack{
                    Text("Computers move")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(5)
                    Text(computerChoice)
                        .font(.title.bold())
                        .padding(.bottom, 40)
                        .shadow(radius: 10)
                }
                HStack{
                    ForEach(0..<3){ number in
                        Button{
                            buttonTapped(number: number)
                        } label: {
                            Text(moves[number])
                                .font(.system(size: 70))
                                .padding()
                                .shadow(radius: 10)
                        }
                    }
                }
            }
            .padding(.vertical,30)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            Spacer()
            Spacer()
            VStack{
                Text("Score: \(userScore)")
                Text("Round: \(currentRound)")
                    
            }
            .foregroundStyle(.white)
            .shadow(radius: 20)
            .font(.title3)
            
            
            
        }
        .alert(alertMessage, isPresented: $showingAlert){
            Button("Continue", action: newQuestion)
        } message: {
            Text("Score: \(userScore)")
        }
        .alert("Round is over", isPresented: $roundOver){
            Button("Restart", action: gameOver)
        } message: {
            Text("Score: \(userScore)")
        }
    }
        
    }
    
    func buttonTapped(number: Int){
        winBool ? shouldWin(number) : shouldLose(number)
    }
    
    func shouldLose(_ number: Int){
        (loses[computerChoice] == moves[number]) ? won() : lost()
    }
    func shouldWin(_ number: Int){
        
        (loses[computerChoice] == moves[number] || moves[number] == computerChoice) ? lost() : won()
    }
    
    func won(){
        alertMessage = "Correct"
        userScore += 1
        showingAlert = true
    }
    
    func lost(){
        alertMessage = "Wrong"
        showingAlert = true
    }
    
    func newQuestion(){
        if(currentRound < 10){
            computerChoice = moves.randomElement() ?? "🪨"
            winBool = Bool.random()
            currentRound+=1
        }
        else{
            roundOver = true
        }
    }
    func gameOver(){
        roundOver = false
        currentRound = 0
        userScore = 0
        newQuestion()
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
