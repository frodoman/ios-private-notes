//
//  LoginView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @State var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Private notes")
                .font(.title)
                .padding()
            Text("Please login")
                .font(.title2)
            Spacer()
            Button(action: {
                self.requestAuthentication()
            }, label: {
                CTALabel(title: "Login")
            })
            Spacer()
        }
    }
    
    private func requestAuthentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Authenticate to access the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success{
                    print("successed")
                    isAuthenticated = true
                }else{
                    print("failed")
                }
            }
        }else{
            // Device does not support Face ID or Touch ID
            print("Biometric authentication unavailable")
        }
    }
}

#Preview {
    LoginView()
}
