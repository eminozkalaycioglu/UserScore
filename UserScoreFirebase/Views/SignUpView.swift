//
//  SignUpView.swift
//  UserScoreFirebase
//
//  Created by Emin on 12.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI


struct SignUpView: View {
    @State var present: Bool = false
    @State var presentSignInView: Bool = false
    @State var showAlert = false
    @State var errorDescription = ""
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var pass: String = ""
    
    @State var emailSelected = false
    @State var fullNameSelected = false
    @State var passSelected = false
    
    var body: some View {
        ZStack(alignment: .center) {
            NavigationLink("", destination: UserProfilePageView().navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: self.$present)
            
            NavigationLink("", destination: SignInView(), isActive: self.$presentSignInView)
            VStack {
                TextField("Full Name:", text: self.$fullName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(self.fullNameSelected ? Color.pink : Color.gray, lineWidth: 2))
                    .padding(.horizontal)
                    .onTapGesture {
                        
                        withAnimation {
                            self.fullNameSelected = true
                            self.passSelected = false
                            self.emailSelected = false
                        }
                        
                }
                TextField("E-mail:", text: self.$email)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(self.emailSelected ? Color.pink : Color.gray, lineWidth: 2))
                    .padding(.horizontal)
                    .onTapGesture {
                        
                        withAnimation {
                            self.emailSelected = true
                            self.passSelected = false
                            self.fullNameSelected = false
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
                            self.fullNameSelected = false
                        }
                }
                
                Button(action: {
                    
                    FirebaseConnection.shared.createUser(fullName: self.fullName, email: self.email, pass: self.pass, completion: { (error) in
                        if let error = error {
                            
                            self.showAlert = true
                            self.errorDescription = error
                        }
                        else {
                            
                            self.present = true
                            
                        }
                        
                    })
                    
                }) {
                    HStack {
                        Spacer()
                        Text("Sign Up").foregroundColor(.white)
                        Spacer()
                    }
                    
                    
                }.padding(.all)
                    
                    .background(LinearGradient(gradient: Gradient(colors: [.blue,.purple]), startPoint: .trailing, endPoint: .leading))
                    .cornerRadius(10)
                    .padding(.all)
                
                
                HStack {
                    Text("I'm already a member,")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    Button(action: {
                        self.presentSignInView = true
                    }) {
                        Text("Sign In")
                            .font(.system(size: 15))
                            .foregroundColor(.pink)
                        
                    }
                    
                }.padding(.vertical)
                
                
            }
            
        }
            
        .navigationBarTitle(Text("Welcome").font(.largeTitle))
            
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Error"), message: Text(self.errorDescription), dismissButton: .default(Text("Try Again")))
        }
        
        
        
        
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
