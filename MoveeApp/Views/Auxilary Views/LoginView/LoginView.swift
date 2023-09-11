//
//  LoginView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 3.09.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @State var showIndicator = false
    
    let tmdbPrimaryColor: Color = Color(red: 1 / 255, green: 180 / 255, blue: 228 / 255)

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                if let image = UIImage(named: "logo") {
                    Image(uiImage: image)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    TextField(
                        "Username",
                        text: $viewModel.username
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    
                    Divider()
                    
                    SecureField(
                        "Password",
                        text: $viewModel.password
                    )
                    .padding(.top, 20)
                    
                    Divider()
                    
                    if let url = URL(string: "https://www.themoviedb.org/reset-password") {
                        Link("Forget Password?", destination: url)
                        .padding(.top, 20)
                    }

//                    Text("Error message: \(viewModel.errorMessage)")
//                        .padding(.top, 20)
                }
                
                Spacer()
                Button {
                    self.showIndicator.toggle()
                    viewModel.login { result in
                        switch result {
                        case .success(let success):
                            authentication.changeAuthenticateState(state: success)
                            self.showIndicator.toggle()
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.showIndicator.toggle()
                        }
                    }
                } label: {
                    Text("Login")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(tmdbPrimaryColor)
                        .cornerRadius(10)
                }
                
                
                if let url = URL(string: "https://www.themoviedb.org/signup") {
                    Link("Register", destination: url)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(tmdbPrimaryColor)
                        .cornerRadius(10)
                }
            }
            
            if showIndicator {
                ProgressView()
            }
        }
        .padding(30)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
