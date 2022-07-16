//
//  ContentView.swift
//  Edutainment
//
//  Created by newbie on 13.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var from = 2
    @State private var to = 12
    @State private var numberOfQuestions = 10
    @State private var score = 0
    @State private var questions = [Question(questionText: "2 * 2", answer: 4)]
    @State private var currentQuestion = 0
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    private let alertTitle = "You answered all the questions"
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Stepper("From \(from)", value: $from)
                    Stepper("To \(to)", value: $to)
                    Stepper("Number of questions \(numberOfQuestions)", value: $numberOfQuestions)
                } .onChange(of: from) { _ in
                    generateQuestions()
                } .onChange(of: to) { _ in
                    generateQuestions()
                } .onChange(of: numberOfQuestions) { _ in
                    generateQuestions()
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    let answer = questions[currentQuestion].answer
                    Text(questions[currentQuestion].questionText)
                        .font(.largeTitle)
                    
                    HStack {
                        let randomButton = Int.random(in: 0...2)
                        ForEach(0..<3) { n in
                            if randomButton == n {
                                Button(String(questions[currentQuestion].answer)) {
                                    score += 1
                                    answerButtonPressed()
                                }
                            } else {
                                Button(String(Int.random(in: from...answer*2))) {
                                    answerButtonPressed()
                                }
                            }
                        }
                    }
                }
                .background(.thinMaterial)
                
                Spacer()
                
                Text("Score: \(score)")
                Text("Question: \(currentQuestion+1)/\(numberOfQuestions)")
            }
            .padding()
            .navigationTitle("Edutainment")
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {
                    generateQuestions()
                }
            } message: {
                Text(alertMessage)
            }
            .onAppear {
                    generateQuestions()
                }
            }
        }
    
    private func generateQuestions() {
        for _ in 0..<numberOfQuestions {
            let random1 = Int.random(in: from...to)
            let random2 = Int.random(in: from...to)
            let question = "\(random1) * \(random2)"
            let answer = random1 * random2
            questions.insert(Question(questionText: question, answer: answer), at: 0)
            score = 0
            currentQuestion = 0
        }
    }
    
    private func answerButtonPressed() {
        if currentQuestion+1 == numberOfQuestions {
            showAlert = true
            alertMessage = "Your score is \(score) points"
        } else {
            currentQuestion += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
