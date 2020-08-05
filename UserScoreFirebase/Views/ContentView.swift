//
//  ContentView.swift
//  UserScoreFirebase
//
//  Created by Emin on 12.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   
    @ViewBuilder
    var body: some View {
        
        
        NavigationView {
            if FirebaseConnection.shared.signed() {
                UserProfilePageView()
            }
            else {
                HomePageView()
            }
        }
        .navigationBarHidden(true).navigationBarTitle("")
        
        
        
    }
    
    
    
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
