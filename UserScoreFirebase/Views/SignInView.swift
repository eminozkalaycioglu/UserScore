//
//  SignInView.swift
//  UserScoreFirebase
//
//  Created by Emin on 20.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var present: Bool = false
    @State var presentSignUpView: Bool = false
    @State var showAlert = false
    @State var errorDescription = ""
    @State var email: String = ""
    @State var pass: String = ""
    
    @State var emailSelected = false
    @State var passSelected = false
    
    var body: some View {
        ZStack {
            NavigationLink("", destination: UserProfilePageView().navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: self.$present)
            
            NavigationLink("", destination: SignUpView(), isActive: self.$presentSignUpView)
            
            VStack {
                TextField("E-mail:", text: self.$email)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(self.emailSelected ? Color.pink : Color.gray, lineWidth: 2))
                    .padding(.horizontal)
                    .onTapGesture {
                        
                        withAnimation {
                            self.emailSelected = true
                            self.passSelected = false
                        }
                        
                }
                SecureField("Password", text: self.$pass)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(self.passSelected ? Color.pink : Color.gray, lineWidth: 2))
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation {
                            self.emailSelected = false
                            self.passSelected = true
                        }
                        
                }
                
                
                Button(action: {
                    
                    FirebaseConnection.shared.signIn(withEmail: self.email, password: self.pass) { (error) in
                        if let error = error {
                            
                            self.showAlert = true
                            self.errorDescription = error
                        }
                        else {
                            self.present = true
                        }
                    }
                    
                }) {
                    HStack {
                        Spacer()
                        Text("Sign In").foregroundColor(.white)
                        Spacer()
                    }
                    
                    
                    }.padding(.all)
                    
                    .background(LinearGradient(gradient: Gradient(colors: [.blue,.purple]), startPoint: .trailing, endPoint: .leading))
                    .cornerRadius(10)
                    .padding(.all)
                
                
                HStack {
                    Text("I'm a new user,")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    Button(action: {
                        self.presentSignUpView = true
                    }) {
                        Text("Sign Up")
                            .font(.system(size: 15))
                            .foregroundColor(.pink)
                        
                    }
                    
                }.padding(.vertical)
                
            }
            
        }
         
        .navigationBarTitle(
            Text("Sign In").font(.largeTitle)
        )
            
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Error"), message: Text(self.errorDescription), dismissButton: .default(Text("Try Again")))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
