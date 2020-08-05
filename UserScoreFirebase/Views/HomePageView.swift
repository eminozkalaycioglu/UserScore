//
//  HomePageView.swift
//  UserScoreFirebase
//
//  Created by Emin on 18.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    @State var showSignInView = false
    @State var showSignUpView = false
    
    
    
    var body: some View {
        
        ZStack {
            Color.init(hex: "660033")
                .opacity(1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                HStack {
                    NavigationLink(destination: SignUpView()) {
                        self.drawSignButton(title: "Sign Up", gradientColors: [.red, .orange])
                    }
                    
                    NavigationLink(destination: SignInView()) {
                        self.drawSignButton(title: "Sign In", gradientColors: [.blue, .black])
                    }
                }
            }
        }
        
        
    }
    
    func drawSignButton(title: String, gradientColors: [Color]) -> AnyView {
        return AnyView(
            
            Text(title)
                .foregroundColor(gradientColors.first)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .trailing, endPoint: .leading), lineWidth: 5))
                .padding(5)
                .background(Color.white.cornerRadius(20))
                .padding()
            
            
            
        )
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
