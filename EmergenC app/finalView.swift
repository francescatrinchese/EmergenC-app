//
//  finalView.swift
//  EmergenC app
//
//  Created by Francesca Trinchese on 12/12/24.
//

import SwiftUI

struct FinalView: View {
    var body: some View {
        TabView {
            // Scheda Home
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            // Scheda First Aid
            FirstAidView()
                .tabItem {
                    Image(systemName: "cross.case.fill")
                    Text("First aid")
                }
        }
    }
}
#Preview {
    FinalView()
}
