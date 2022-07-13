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
    
    private var currentQuestion = 0
    @State private var questions = [Question(questionText: "2 * 2", answer: 4)]
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper("From \(from)", value: $from)
                Stepper("To \(to)", value: $to)
                Stepper("Number of questions \(numberOfQuestions)", value: $numberOfQuestions)
                
                Text(questions[currentQuestion].questionText)
                
                HStack {
                    Button("10") {
                        // do nothing for now
                    }
                    Button("11") {
                        // do nothing for now
                    }
                    Button("12") {
                        // do nothing for now
                    }
                }
                
                Text("\(currentQuestion+1)/\(numberOfQuestions)")
            }
            .padding()
            .navigationTitle("Edutainment")
            .onAppear {
                for _ in 0..<numberOfQuestions {
                    let random1 = Int.random(in: from...to)
                    let random2 = Int.random(in: from...to)
                    let question = "\(random1) * \(random2)"
                    let answer = random1 * random2
                    questions.insert(Question(questionText: question, answer: answer), at: 0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
