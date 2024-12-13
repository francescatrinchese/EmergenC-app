//
//  ContentView.swift
//  EmergenC app
//
//  Created by Francesca Trinchese on 11/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // Regione iniziale della mappa
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8326, longitude: 14.3121), // San Giovanni a Teduccio (Napoli)
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            VStack {
                MapView()
                // Mappa
                //Map(coordinateRegion: $region)
                  .frame(height: 360)
                  .cornerRadius(10)
                  .padding()

                // Contenitore bianco con bordi grigi
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            HStack{
                                Text("Emergency calls")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding([.leading, .bottom], 20)
                            Spacer()
                                
                            }
                            
                            HStack {
                                EmergencyButton(number: "118", label: "Ambulance", color: .orange)
                                Spacer()
                                EmergencyButton(number: "113", label: "Police", color: .blue)
                                Spacer()
                                EmergencyButton(number: "115", label: "Firefighters", color: .red)
                            }
                            .padding(.horizontal, 20)
                        }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding()

                Spacer()
            }
            .navigationTitle("EmergenC")
            
        }
    }
}

struct EmergencyButton: View {
    var number: String
    var label: String
    var color: Color

    var body: some View {
        Button(action: {
            // Avvio della chiamata al numero di emergenza
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.open(url)
            }
        }) {
            VStack {
                Text(number)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(label)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 80)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
