//
//  ProfileView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import SwiftUI

struct ProfileView: View {
  @State private var myProfile: Profile?
  
  var body: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 5) {
        Image("image_profile")
          .resizable()
          .frame(width: 120, height: 120)
          .clipShape(Circle())
          .padding(.top, 30)
        
        Text(myProfile?.name ?? "Unknown")
          .font(.system(size: 20))
          .bold()
          .padding(.top, 5)
        
        HStack {
          cellCard(header: "Academy", value: "25")
            .frame(maxWidth: .infinity, alignment: .center)
          Spacer()
          cellCard(header: "XP", value: "9.999")
            .frame(maxWidth: .infinity, alignment: .center)
          Spacer()
          cellCard(header: "Point", value: "235")
            .frame(maxWidth: .infinity, alignment: .center)
          Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.vertical, 20)
        .padding(.horizontal, 40)
        
        
        Text("Contact")
          .bold()
          .font(.system(size: 16))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top)
          .padding(.horizontal)
        
        HStack(alignment: .center, spacing: 15) {
          Image("ic_phone")
            .resizable()
            .frame(width: 30, height: 30)
          
          Text(myProfile?.numberPhone ?? "-")
            .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding(.horizontal)
        
        HStack(alignment: .center, spacing: 15) {
          Image("ic_mail")
            .resizable()
            .frame(width: 30, height: 30)
          
          Text(myProfile?.email ?? "-")
            .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding(.horizontal)
        
        NavigationLink(destination: EditProfileView()) {
          Text("Edit Profile")
            .foregroundColor(.blue)
            .font(.system(size: 16))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(.blue)
            )
            .padding(.vertical)
        }
      }
    }
    .onAppear {
      Profile.synchronize()
      myProfile = Profile.objProfile
    }
    .padding(.top, 2)
    .padding(.bottom)
  }
  
  private func cellCard(header: String, value: String) -> some View {
    VStack {
      Text(header)
        .font(.system(size: 16))
        .foregroundColor(.black)
      Text(value)
        .font(.system(size: 16))
        .bold()
        .foregroundColor(.blue)
        .padding(.top, 1)
    }
  }
}
