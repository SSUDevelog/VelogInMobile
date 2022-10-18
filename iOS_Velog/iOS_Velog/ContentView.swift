//
//  ContentView.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        MyWebview(urlToLoad: "https://www.naver.com")
        
        NavigationView{
            
            HStack{
                NavigationLink(destination:
                    MyWebview(urlToLoad: "https://velog.io/")
                        .edgesIgnoringSafeArea(.all)
                ){
                    Text("Velog")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                NavigationLink(destination:
                    MyWebview(urlToLoad: "https://velog.io/@lms7802")
                    .edgesIgnoringSafeArea(.all)
                ){
                    Text("Hong_Velog")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                NavigationLink(destination:
                    MyWebview(urlToLoad: "https://velog.io/@cjiu0201")
                    .edgesIgnoringSafeArea(.all)
                ){
                    Text("Choi_Velog")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
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
