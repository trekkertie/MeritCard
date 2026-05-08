//
//  MeritEnterProject.swift
//  MeritCard
//
//  Created by Jonathan Preston on 20/11/2024.
//

import SwiftUI

struct MeritEnterPassword: View {
    @Environment(\.dismiss) var dismiss
    @State private var password: String = ""
    @Binding var clearMerit: Bool
    
    var body: some View {
            VStack (alignment: .center){
                Image("Logo")
                Text("Please enter your password and click Clear Data.")
                SecureField("Password", text: $password)
                    .frame(width: 240 , height: 40)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .border(Color.black, width: 1)
                HStack{
                    Button("Clear Data") {
                        Task {
                            if password == "higherbye" {
                                clearMerit = true
                            }
                            else {
                                clearMerit = false
                            }
                            dismiss()
                        }
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    Button("Cancel") {
                        Task {
                            clearMerit = false
                            dismiss()}
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
            }
    }
}

//#Preview {
//    MeritEnterPassword()
//}
