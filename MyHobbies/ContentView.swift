//
//  ContentView.swift
//  MyHobbies
//
//  Created by Tomotaka Kawai on 2024/03/09.
//

import SwiftUI

struct ContentView: View {
    let api = API()
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                api.getStoreData()
            }) {
                Text("Button")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

