//
//  ContentView.swift
//  HomeDoctor
//
//  Created by Hillarie  on 07/07/2020.
//  Copyright © 2020 Hillarie. All rights reserved.
//

import SwiftUI
import Combine

class HttpAuth : ObservableObject {
    var didchange = PassthroughSubject<HttpAuth, Never>()
    var authenticated = false
    {
        didSet {
        didchange.send(self)
        }
}
    func checkDetails(username: String, pass: String){
        guard let url = URL(string: "https://homedoctorapi.esquekenya.com/api/Users/Login")
            else { return }
        let body:[String: String] = ["Email": username, "Password": pass]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        //let finalBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        var request  = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody=finalBody
       // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else
            {
                return
                
            }
            let finalData = try! JSONDecoder().decode(UserModel.self, from: data)

            debugPrint("Response",finalData)
            
            
            if (finalData.Success==true){
                DispatchQueue.main.async{
                self.authenticated=true
              
                }
            }
            
        }.resume()
   
}
}

 struct  UserModel : Decodable {
    let FirstName,Message: String
    let Success : Bool
    
   
}

struct LoginView: View {
     var body: some View {
         
         ZStack{
             
             LinearGradient(gradient: .init(colors: [Color("colorPrimaryDark"),Color("colorPrimaryDark"),Color("colorPrimaryDark")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
             
             if UIScreen.main.bounds.height > 800{
                 
                 Home()
             }
             else{
                 
                 ScrollView(.vertical, showsIndicators: false) {
                     
                     Home()
                 }
             }
         }
     }
 }
 
 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         SignUp()
     }
 }
 
 struct Home : View {
     
     @State var index = 0
     
     var body : some View{
         
         VStack{
             
             Image("logo")
             .resizable()
             .frame(width: 200, height: 200)
             
             HStack{
                 
                 Button(action: {
                     
                     withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                         
                        self.index = 0
                     }
                     
                 }) {
                     
                     Text("existing")
                         .foregroundColor(self.index == 0 ? .black : .white)
                         .fontWeight(.bold)
                         .padding(.vertical, 10)
                         .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                     
                 }.background(self.index == 0 ? Color.white : Color.clear)
                 .clipShape(Capsule())
                 
                 Button(action: {
                     
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                       self.index = 1
                    }
                     
                 }) {
                     
                     Text("new")
                         .foregroundColor(self.index == 1 ? .black : .white)
                         .fontWeight(.bold)
                         .padding(.vertical, 10)
                         .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                     
                 }.background(self.index == 1 ? Color.white : Color.clear)
                 .clipShape(Capsule())
                 
             }.background(Color.black.opacity(0.1))
             .clipShape(Capsule())
             .padding(.top, 25)
             
             if self.index == 0{
                 
                 Login()
             }
             else{
                 
                 SignUp()
             }
             
             if self.index == 0{
                 
                 Button(action: {
                     
                 }) {
                     
                     Text("Forget Password?")
                         .foregroundColor(.white)
                 
                 }
                 .padding(.top, 20)
             }
             
             HStack(spacing: 15){
                 
                 Color.white.opacity(0.7)
                 .frame(width: 35, height: 1)
                 
                 Text("Or")
                     .fontWeight(.bold)
                     .foregroundColor(.white)
                 
                 Color.white.opacity(0.7)
                 .frame(width: 35, height: 1)
                 
             }
             .padding(.top, 10)
             
             
             
         }
         .padding()
     }
 }
 
 struct Login : View {
     
     @State var mail = "0720968729"

     @State var pass = "12345"
   @State var manager = HttpAuth()
     
     var body : some View{
         
         VStack{
             
             VStack{
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "envelope")
                         .foregroundColor(.black)
                     
                    TextField("Email Address", text: self.$mail)
                     
                 }.padding(.vertical, 20)
                 
                 Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     TextField("Password", text: self.$pass)
                     
                     Button(action: {
                         
                     }) {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
             }
             .padding(.vertical)
             .padding(.horizontal, 20)
             .padding(.bottom, 40)
             .background(Color.white)
             .cornerRadius(10)
             .padding(.top, 25)
             
         if manager.authenticated{
     
                                    
           }
             Button(action: {
                self.manager.checkDetails(username : self.mail,pass : self.pass)
                             
             })
        {
                 // NavigationLink(destination: DoctorView()) {
          Text("LOGIN")
          .foregroundColor(.white)
          .fontWeight(.bold)
          .padding(.vertical)
          .frame(width: UIScreen.main.bounds.width - 100)
                      //  }
            
             }.background(
             
                 LinearGradient(gradient: .init(colors: [Color("colorPrimaryDark"),Color("colorPrimaryDark"),Color("colorPrimaryDark")]), startPoint: .leading, endPoint: .trailing)
             )
             .cornerRadius(15)
             .offset(y: -40)
             .padding(.bottom, -40)
             .shadow(radius: 15)
         }
     }
 }
 
 struct SignUp : View {
     
        @State var FirstName = ""
        @State var LastName = ""
        @State var Gender = ""
        @State var PhoneNumber = ""
        @State var Age = ""
        @State var mail = ""
       
     
     var body : some View{
         
         VStack{
             
             VStack{
                 
                 HStack(spacing: 15){
                                                 
                                                 Image(systemName: "envelope")
                                                     .foregroundColor(.black)
                                                 
                    TextField("Enter First Name ", text: self.$FirstName)
                                                 
                                             }.padding(.vertical, 20)
                            
                             Divider()
                HStack(spacing: 15){
                                                
                                                Image(systemName: "envelope")
                                                    .foregroundColor(.black)
                                                
                                                TextField("Enter Last Name ", text: self.$LastName)
                                                
                                            }.padding(.vertical, 20)
                           
                            Divider()
                HStack(spacing: 15){
                                                
                                                Image(systemName: "envelope")
                                                    .foregroundColor(.black)
                                                
                                                TextField("Enter PhoneNumber ", text: self.$PhoneNumber)
                                                
                                            }.padding(.vertical, 20)
                           
                            Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     TextField(" Age ", text: self.$Age)
                     
                     Button(action: {
                       print("Delete tapped!")
                
                     }) {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
                 Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     TextField("Re-Enter", text: self.$mail)
                     
                     Button(action: {
                         
                     }) {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
             }
             .padding(.vertical)
             .padding(.horizontal, 20)
             .padding(.bottom, 40)
             .background(Color.white)
             .cornerRadius(10)
             .padding(.top, 25)
             
             
             Button(action: {
                 
             }) {
                 
                 Text("SIGNUP")
                     .foregroundColor(.white)
                     .fontWeight(.bold)
                     .padding(.vertical)
                     .frame(width: UIScreen.main.bounds.width - 100)
                 
             }.background(
             
                 LinearGradient(gradient: .init(colors: [Color("colorPrimaryDark"),Color("colorPrimaryDark"),Color("colorPrimaryDark")]), startPoint: .leading, endPoint: .trailing)
             )
             .cornerRadius(8)
             .offset(y: -40)
             .padding(.bottom, -40)
             .shadow(radius: 15)
         }
     }
 }

  
       
