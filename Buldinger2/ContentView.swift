//
//  ContentView.swift
//  Buldinger2
//
//  Created by Hadi Mortazavi on 18.09.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    NavigationLink(destination: VRModelView()) {
                        Text("Model1")
                    }
                }
            }
        
        VStack{
            Spacer()
              
              HStack {
                  Spacer()
                  Button(action: {
                      
                  }, label: {
                      Text("+")
                          .font(.system(.largeTitle))
                          .frame(width: 77, height: 70)
                          .foregroundColor(Color.white)
                          .padding(.bottom, 7)
                  })
                  .background(Color.blue)
                  .cornerRadius(38.5)
                  .padding()
                  .shadow(color: Color.black.opacity(0.3),
                          radius: 3,
                          x: 3,
                          y: 3)
                
                
              }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
