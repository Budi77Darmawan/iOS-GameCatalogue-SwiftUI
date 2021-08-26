//
//  EditProfileView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 23/08/21.
//

import SwiftUI

struct EditProfileView: View {
  @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
  @State private var name = ""
  @State private var numberPhone = ""
  @State private var email = ""
  @State private var alertIsPresented = false
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 5) {
        HStack {
          Image("image_profile")
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 30)
        .padding(.bottom, 20)
        
        Text("Fullname")
          .font(.system(size: 16))
          .padding(.bottom, 1)
        
        TextField("Input your fullname", text: $name)
          .disableAutocorrection(true)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.bottom)
        
        Text("Number Phone")
          .font(.system(size: 16))
          .padding(.bottom, 1)
        
        TextField("Input your number phone", text: $numberPhone)
          .disableAutocorrection(true)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.bottom)
        
        Text("Email")
          .font(.system(size: 16))
          .padding(.bottom, 1)
        
        TextField("Input your email", text: $email)
          .disableAutocorrection(false)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.bottom)
        
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal)
    }
    .onAppear {
      Profile.synchronize()
      let myProfile = Profile.objProfile
      name = myProfile.name
      numberPhone = myProfile.numberPhone
      email = myProfile.email
    }
    .padding(.top, 2)
    .padding(.bottom)
    .navigationBarTitle("Edit Profile")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          updateProfile()
        }) {
          Text("Save")
            .foregroundColor(.blue)
        }
      }
    }
    .alert(isPresented: $alertIsPresented, content: {
      Alert(title: Text("Alert"),
            message: Text("Unable to update because there is an empty field"),
            dismissButton: .default(Text("Got it!"))
      )
    })
  }
  
  private func updateProfile() {
    if name.trimmingCharacters(in: .whitespaces).isEmpty ||
        numberPhone.trimmingCharacters(in: .whitespaces).isEmpty ||
        email.trimmingCharacters(in: .whitespaces).isEmpty {
      alertIsPresented = true
    } else {
      let newObjProfile = Profile(name: name, numberPhone: numberPhone, email: email)
      Profile.objProfile = newObjProfile
      self.mode.wrappedValue.dismiss()
    }
  }
  
}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView()
  }
}
