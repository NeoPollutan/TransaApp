//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Rizky Adipratama Ruddyar on 28/04/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "Kami membutuhkan akses faceID anda untuk membantu menjaga keamanan data."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    DispatchQueue.main.async {
                        if success {
                            self.isUnlocked = true
                        } else {
                            print(error?.localizedDescription ?? "Failed to authenticate")
                            // there was a problem
                        }
                    }
                }
            } else {
                // no biometrics
            }
        }
    
    @State private var isUnlocked = false

    var body: some View {
        VStack
            {
                if self.isUnlocked {
                    
                    TabView {
                        
                        HomeView()
                            .tabItem {
                                VStack {
                                    Text("Home")
                                    Image(systemName: "house.fill")
                                }
                        }
                        .tag(0)
                        
                        
                        LogsTabView()
                            .tabItem {
                                VStack {
                                    Text("Rangkuman")
                                    Image(systemName: "tray.fill")
                                }
                        }
                        .tag(1)
                        
                        ProfileFilled()
                                       .tabItem {
                                           VStack {
                                               Text("Profil")
                                               Image(systemName: "person.fill")
                                           }
                                   }
                                   .tag(2)
                    }

                    
                } else {
                    Image("anonymity") .resizable() .frame(width: 200, height: 200, alignment: .center) .padding(.bottom ,40)
                    Text("User tidak dikenal") .font(.body) .multilineTextAlignment(.center)
                }
            
        }.onAppear(perform: authenticate)
        
        

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
