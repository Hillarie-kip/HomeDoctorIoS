//
//  SplashScreen.swift
//  HomeDoctor
//
//  Created by Hillarie  on 07/07/2020.
//  Copyright © 2020 Hillarie. All rights reserved.
//

import SwiftUI




struct SplashScreen: View {
     @State public var isActive = false
    var body: some View {
          NavigationView {
              VStack {
                  Image("logo")
                  NavigationLink(destination: LoginView(),
                                 isActive: $isActive,
                                 label: { SplashScreen() })
              }
              .onAppear(perform: {
                  self.gotoLoginScreen(time: 2.5)
              })
          }
      }
    func gotoLoginScreen(time: Double) {
          DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
              self.isActive = true
          }
      }





}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
       SplashScreen()
    }
}
