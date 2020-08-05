//
//  UserProfilePageView.swift
//  UserScoreFirebase
//
//  Created by Emin on 18.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct UserProfilePageView: View {
    @State private var email: String = ""
    @State private var score: Int = 0
    @State private var present = false
    private var uid: String = ""
    
    
    init() {
        self.uid = FirebaseConnection.shared.getCurrentID() ?? ""
        
    }
    var body: some View {
        
        VStack {
            Text("E-Mail: \(self.email)")
            
            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $present) {
                Text("")
            }
            
            
            Button(action: {
                FirebaseConnection.shared.incrementScore(uid: self.uid, piece: 1) { (score) in
                    
                    if let score = score {
                        self.score = score
                    }
                }
                
                FirebaseConnection.shared.incrementScore(uid: self.uid, piece: 1)
            }) {
                Text("Increment Score")
            }
            
            Button(action: {
                if FirebaseConnection.shared.signOut() {
                    self.present = true
                }
                
            }, label: {
                Text("Sign Out")
            })
            
            HStack(alignment: .center) {
                
                Text("Your Score: ")
                Text(self.score.description)
                
            }
            
        }.onAppear {
            FirebaseConnection.shared.getSpecificUserScore(uid: self.uid) { (receivedScore) in
                self.score = receivedScore
            }
            
            self.email = FirebaseConnection.shared.showCurrentUserMail()
            
        }
    
        
        
        
        
    }
}

struct UserProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePageView()
    }
}
