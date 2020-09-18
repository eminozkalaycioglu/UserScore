//
//  FirebaseConnection.swift
//  UserScoreFirebase
//
//  Created by Emin on 12.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Firebase
class FirebaseConnection {
    
    private init() {
        
    }
    
    static let shared = FirebaseConnection()
    private var ref: DatabaseReference!
    
    
    func createUser(fullName: String? = nil, email: String, pass: String,completion: ((String?) -> ())? = nil) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                
                completion?(error?.localizedDescription)
                return
            }
            
            guard let uid = user?.user.uid else {
                completion?("uid not found")
                return
            }
            
            self.saveWithInfos(email: email, fullName: fullName ?? "noname", uid: uid)
            
            completion?(nil)
        }
        
    }
    
    private func saveWithInfos(email: String, fullName: String, uid: String) {

        self.ref = Database.database().reference()

        var dictionary: [String:Any] = [:]
        dictionary["fullname"] = fullName
        dictionary["uid"] = uid
        dictionary["email"] = email
        
        let userInfos = self.ref.child("userInfos").child(uid)
        userInfos.setValue(dictionary)
        
        let userScore = self.ref.child("userScores").child(uid)
        dictionary.removeAll()
        dictionary["score"] = 0
        userScore.setValue(dictionary)
        
        
    }
    
    func incrementScore(uid: String, piece: Int, _ completion: ((Int?) -> ())? = nil) {

        
        self.ref = Database.database().reference()

        var dictionary: [String:Any] = [:]
        let specificUser = self.ref.child("userScores").child(uid)
        
        specificUser.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var score = (value?["score"] as? Int) ?? 0
            score += piece
            
            dictionary["score"] = score
            specificUser.setValue(dictionary) { (error, _) in
                if error == nil {
                    completion?(score)
                    return
                }
                completion?(nil)
                
            }
            
        }
        
    }
    
    
    
    func getSpecificUserScore(uid: String, _ completion: ((Int) -> ())? = nil) {
        self.ref = Database.database().reference()

        if self.signed() && uid.count != 0 {
            
            let specificUser = self.ref.child("userScores").child(uid)
            
            specificUser.observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = (value?["score"] as? Int) ?? 0
                completion?(score)
                return
                
            }
        }
        
    }
    
    func signIn(withEmail email: String, password: String, _ completion: ((String?) -> ())? = nil){

        self.ref = Database.database().reference()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                completion?(error?.localizedDescription)
                return
            }
            if let uid = user?.user.uid {
                print("uid: ", uid)
            }
            completion?(nil)
        }
    }
    
    func getCurrentID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    func signOut() -> Bool{
        do{
            try Auth.auth().signOut()
            return true
        }catch{
            return false
        }
    }
    
    func showCurrentUserMail() -> String {
        return Auth.auth().currentUser?.email ?? "current user mail bulunamadi..."
    }
    
    func signed() -> Bool {

        return Auth.auth().currentUser == nil ? false : true
        
    }
    
}
