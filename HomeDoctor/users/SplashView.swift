//
//  SplashView.swift
//  HomeDoctor
//
//  Created by Hillarie  on 08/07/2020.
//  Copyright © 2020 Hillarie. All rights reserved.
//

import SwiftUI

struct SplashView: View {
        @State private var isActive = false
    var body: some View {
        
              NavigationView {
                NavigationLink(destination: LoginView(),
                                       isActive: $isActive,
                                       label: { SplashPage() })
                   
                    }
                
                    .onAppear(perform: {
                        self.gotoLoginScreen(time: 2.5)
                    })
                }
    
    
    
    func gotoLoginScreen(time: Double) {
             DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
                 self.isActive = true
             }
         }

    
}




struct SplashPage: View {
  
    var body: some View {
           NavigationView {
        ZStack{
          Color("colorPrimaryDark")
                              Image("logo")
                              .resizable()
                              .frame(width: 200, height: 200)
                       
            
        }.edgesIgnoringSafeArea(.all)
        }
        }
       
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
