//
//  ContentView.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/19.
//

import SwiftUI

struct ContentView: View {
    
    let backgroundColor = Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)

    init() {
        UITabBar.appearance().backgroundColor = UIColor(backgroundColor)
    }
    
    var body: some View {
        
        TabView{
            HomeView()
        
            Text("Home")
                .tabItem{
                    Image(systemName: "calendar")
                    Text("달력")
                }
            Text("Home")
                .tabItem{
                    Image(systemName: "chart.pie")
                    Text("통계")
                }
            Text("Home")
                .tabItem{
                    Image(systemName: "doc.text")
                    Text("예산")
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
