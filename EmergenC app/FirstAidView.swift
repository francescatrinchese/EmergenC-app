//
//  FirstAidView.swift
//  EmergenC app
//
//  Created by Francesca Trinchese on 11/12/24.
//
import SwiftUI

//struct HomeView: View {
//    var body: some View {
//        VStack {
//            Text("Welcome to EmergenC")
//                .font(.title)
//
//                .padding()
//            Spacer()
//        }
//    }
//}

struct FirstAidView: View {
    @State private var isModalPresented = false
    @State private var selectedTopic: FirstAidTopic?

    var body: some View {
        NavigationView {
            VStack {
                // Titolo
                VStack{
                    HStack{
                        Text("First aid")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Text("Information about first aid")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                }
                .background(Color.red)
                
                
                // Griglia di rettangoli
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(FirstAidTopic.allCases, id: \.self) { topic in
                            Button(action: {
                                selectedTopic = topic
                                isModalPresented = true
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(height: 170)
                                    .shadow(radius: 3)
                                    .overlay(
                                        VStack {
                                            Image(systemName: topic.iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                                .foregroundColor(.black)
                                                .padding(.bottom)
                                            Text(topic.title)
                                                .font(.body)
                                                .foregroundColor(.black)
                                        }
                                    )
                            }
                        }
                    }
                    .padding()
                }
            }
            /*.navigationTitle("First aid")*/
        }
        .sheet(isPresented: $isModalPresented) {
            if let topic = selectedTopic {
                FirstAidDetailView(topic: topic)
            }
        }
    }
}

// Modale di dettaglio
struct FirstAidDetailView: View {
    var topic: FirstAidTopic

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    Text(topic.description)
                        .font(.body)
                        .padding()
                }
                Spacer()
            }
            .navigationTitle(topic.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Modello per le informazioni di primo soccorso
enum FirstAidTopic: String, CaseIterable {
    case choking = "Choking"
    case burns = "Burns"
    case cuts = "Wounds,Bleeding"
    case sprains = "Fainting"

    var title: String {
        rawValue
    }

    var iconName: String {
        switch self {
        case .choking: return "lungs.fill"
        case .burns: return "flame.fill"
        case .cuts: return "drop.fill"
        case .sprains: return "figure.fall"
        }
    }

    var description: String {
        switch self {
        case .choking: return """
        This can happen when food or an object blocks the airway.
            How to Act:
            1. Assess the Situation:
                 If the person is coughing, encourage them to keep coughing—do not interfere.
        
                 If the person cannot speak or breathe:
            2. Perform the Heimlich Maneuver (for adults or children over 1 year old):
                 Stand behind the person.
                 Wrap your arms around their waist.
                 Give a quick, forceful upward thrust just below the ribcage.
            3. For Infants (under 1 year old):
                 Place the infant face down along your forearm, with their head lower than their body.
                 Deliver up to 5 back blows between the shoulder blades using the heel of your hand.
                 If this doesn’t work, turn the infant face up and perform 5 chest compressions using two fingers at the center of the chest..
        
        Always Remember! 
        -Stay Calm: This is essential for managing the situation effectively. 
        -Seek Help if Needed: Don’t hesitate to call emergency services. 
        -Do No Harm: Only perform safe and appropriate actions.
        """
        case .burns: return """
Burns can be caused by heat, chemicals, or electricity. 
How to Act: 
1. Move the Person Away from the Heat Source. 
2. Cool the Burned Area: Place the area under cool running water (not ice-cold) for 10–20 minutes. Do not use ice, butter, or home remedies.
3. Do Not Burst Blisters: They protect the underlying skin. 
4. Cover with a Sterile Dressing: Use a clean cloth if no specific dressing is available. 
5. Call 112: If the burn is severe, covers a large area, or involves the face, hands, feet, or genitals. 

Always Remember! 
-Stay Calm: This is essential for managing the situation effectively. 
-Seek Help if Needed: Don’t hesitate to call emergency services. 
-Do No Harm: Only perform safe and appropriate actions.
"""
        case .cuts: return """
        Cuts or wounds can lead to blood loss and infections.
        How to Act:
        1. Wear Gloves (if available): Protect yourself and the injured person.
        2. Stop the Bleeding:
           Apply direct pressure to the wound with a clean cloth or sterile gauze.
        3. Elevate: Raise the injured area, if possible, to reduce blood flow.
        4. Clean the Wound: Once the bleeding is controlled:
            Wash the wound under clean running water.
            Avoid using alcohol or disinfectants directly on an open wound.
        5. Cover the Wound: Use a sterile bandage to cover it.
        
        Always Remember! 
        -Stay Calm: This is essential for managing the situation effectively. 
        -Seek Help if Needed: Don’t hesitate to call emergency services. 
        -Do No Harm: Only perform safe and appropriate actions.
        """
        case .sprains: return """
Fainting can be caused by stress, heat, hunger, or health problems.
How to Act:
1. Ensure Safety: Make sure the person is in a safe environment.
2. Lay Down: Lay the person on their back.
   Raise their legs about 30 cm (12 inches) to improve blood flow to the brain.
3. Check Breathing: Ensure they are breathing normally.
   If they are not breathing, call 112 immediately and start cardiopulmonary resuscitation (CPR).
4. Help Them Wake Up: If they regain consciousness, help them sit up slowly, then stand.
5. Don’t Ignore It: If the fainting lasts more than a minute or happens repeatedly, contact a doctor.

Always Remember! 
-Stay Calm: This is essential for managing the situation effectively. 
-Seek Help if Needed: Don’t hesitate to call emergency services. 
-Do No Harm: Only perform safe and appropriate actions.
"""
        }
    }
}

struct FirstAidView_Previews: PreviewProvider {
    static var previews: some View {
        FirstAidView()
    }
}
