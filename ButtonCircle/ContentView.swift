//
//  ContentView.swift
//  ButtonCircle
//
//  Created by Šimon Javora on 05/06/2019.
//  Copyright © 2019 Šimon Javora. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    var body: some View {
        ButtonsOnCircle(radius: 100, numberOfButtons: 0) { index in
            print("tapped button at index \(index)")
        }
    }
}

struct ButtonsOnCircle: View {
    
    private struct ButtonPosition: Identifiable {
        
        let index: Int
        let angle: Double
        let radius: Double
        
        var offset: CGSize {
            CGSize(width: radius * cos(angle), height: radius * sin(angle))
        }
        
        var id: Int {
            return index
        }
    }
    
    let radius: Double
    @State var numberOfButtons: Int
    let callback: (_ buttonIndex: Int) -> Void
    
    private var buttonPositions: [ButtonPosition] {
        
        let indices = 0 ..< numberOfButtons
        let angles = indices.map { index in
            Double(index) * 2 * .pi / Double(numberOfButtons)
        }
        
        return zip(indices, angles).map { index, angle in
            ButtonPosition(index: index, angle: angle, radius: radius)
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: CGFloat(radius * 2), height: CGFloat(radius * 2), alignment: .center)
                .foregroundColor(.yellow)
                .padding()
                .tapAction { self.numberOfButtons += 1 }
            ForEach(buttonPositions) { position in
                Button(
                    action: { self.callback(position.index) }
                ) { Text("button \(position.index)") }.offset(position.offset)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
