//
//  ContentView.swift
//  OmgTest
//
//  Created by samil on 08.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var randomNumbers: [Int] = (0..<100).map { _ in Int.random(in: 1...100) }
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(randomNumbers.indices, id: \.self) { index in
                    HorizontalListView(randomNumber: self.$randomNumbers[index])
                        .frame(height: 150)
                }
            }
            .padding()
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) { _ in
            self.randomNumbers = self.randomNumbers.map { _ in Int.random(in: 1...100) }
        }
    }
}

struct HorizontalListView: View {
    @Binding var randomNumber: Int
    @State private var isTapped = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(0..<Int.random(in: 10...20), id: \.self) { _ in
                    SquareView(randomNumber: self.$randomNumber, isTapped: self.$isTapped)
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.3))
    }
}

struct SquareView: View {
    @Binding var randomNumber: Int
    @Binding var isTapped: Bool
    var body: some View {
        let scaledSize: CGFloat = isTapped ? 0.8 : 1.0
        return Text("\(randomNumber)")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(scaledSize)
            .animation(.spring())
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.isTapped.toggle()
                    }
            )
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
