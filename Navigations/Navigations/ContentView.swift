//
//  ContentView.swift
//  Navigations
//
//  Created by salome on 13.12.23.
//

import SwiftUI

class TravelTips:
    ObservableObject {
    @Published var travelTips: [String] =
     [
        "Pack light and versatile – choose multi-purpose clothing items.",
        "Research local customs and etiquette before arriving.",
        "Keep important documents and valuables secure in a travel wallet.",
        "Learn a few basic phrases in the local language for better communication.",
        "Stay hydrated and be mindful of local water safety.",
        "Use local transportation options to immerse yourself in the culture.",
        "Always have a backup power bank for your devices.",
        "Check visa requirements well in advance of your trip.",
        "Stay flexible with your itinerary to embrace unexpected opportunities.",
        "Capture memories but also take time to put the camera down and enjoy the moment."
        ]
        
        func getRandomTip() -> String {
            return
        travelTips.randomElement() ?? ""
        }
    }

struct ContentView: View {
    @State private var isAlertShowed = false
    @StateObject var travelTip = TravelTips()
    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
            
                ForEach(Cities, id:\.name) { city in
                    NavigationLink(destination: CityDetails(city:city)) {
                        VStack {
                            Image(city.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:300, height:200)
                            Text(city.name)
                        }
                        
                    }
                }
                
                Button("show some alert") {
                 
                    isAlertShowed = true
                }.alert(isPresented: $isAlertShowed) {
                    
                    Alert(
                        title: Text("Travel Tips"),
                        message: Text(travelTip.getRandomTip()),
                        primaryButton:  .destructive(
                            Text("ok"),
                            action: {
                                print("Alert pressed")
                            }
                        ),
                        secondaryButton: .cancel()
                    )
                }
                .foregroundColor(.orange)
            }.navigationDestination(for: Int.self) { number in
                NavigationStackOverNavigationViewHelperView(number: number)
            }.navigationDestination(for: String.self) { emoji in
                Text(emoji)
            }
        }
        .font(.system(size: 24, weight: .heavy))
        .baselineOffset(15)
        .foregroundColor(.black)
        .padding(.top, 20)
         
    }
    
    var body1: some View {
        
        NavigationView {
             
            
                ForEach(1..<5) { index in
                    NavigationLink {
                        NavigationStackOverNavigationViewHelperView(number: index)
                    } label: {
                        Text("button: \(index)")
                    }
                }
            
        }
    }
}

struct NavigationStackOverNavigationViewHelperView: View {
   
    let number: Int
    
    init(number: Int) {
        self.number = number
        print("loaded view at index: \(number)")
    }
    
    var body: some View {
        Text("text on index \(number)")
    }
}


#Preview {
    ContentView() 
}
 
