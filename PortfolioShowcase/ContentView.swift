//
//  ContentView.swift
//  PortfolioShowcase
//
//  Created by Sergio Bost on 8/16/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var nm = NetworkManager()
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Navigator(.left){ nm.stepBackwards() }
                    Spacer()
                    ShowcaseImage()
                    Spacer()
                    Navigator(.right) { nm.stepForward() }
                }

                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(nm.currentPortfolio?.name ?? "")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<5){ _ in
                            Button(action: { }) {
                                ShowcaseImage(mini: true)
                                    .padding(.horizontal, 12)
                            }
                        }
                    }
                }
                .onAppear {
                    print("Performing network request...")
                    
                }
                HStack {
                    Spacer()
                    ImageIcon("calendar", value: nm.currentPortfolio?.monthYear ?? "")
                    Spacer()
                    ImageIcon("hourglass", value: String(nm.currentPortfolio?.hoursWorked ?? 0))
                    Spacer()
                    ImageIcon("person.fill", value: nm.currentPortfolio?.team ?? "")
                    
                    Spacer()
                }.transition(.slide)
                .padding()
                Spacer()
                VStack {
                    Text("Frameworks used").underline()
                    ForEach(nm.currentPortfolio?.frameworksUsed ?? [], id: \.self){ fw in
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                            Text(fw).bold()
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.transition(.slide)
                .task {
                    nm.getAllPortfolios { result in
                        switch result {
                            
                        case .success(let portfolios):
                            print(portfolios)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
                
            }.padding()
        }    }
    let frameworksUsed = ["Core Data", "Vapor", "MapKit", "Foundation"]
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

struct Navigator: View {
    
    let direction: Direction
    let scroll: () -> Void
    init(_ direction: Direction, scrollFunction: @escaping () -> Void) {
        self.direction = direction
        self.scroll = scrollFunction
    }
    var body: some View {
        Button(action: scroll){
            Image(systemName: "arrow.\(direction.rawValue).circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }
    enum Direction: String {
        case left   = "left"
        case right  = "right"
    }
}



struct ImageIcon: View {
    let sfSymbol: String
    let value: String
    init(_ sfSymbol: String, value: String){
        self.sfSymbol = sfSymbol
        self.value = value
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.blue)
                    .opacity(0.2)
                    .frame(height: 50)
                VStack {
                    Image(systemName: sfSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                    
                }
            }
            Text(value)
        }
        
    }
}
