//
//  HomeView.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/19.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var accounts: FetchedResults<Account>
    @State var currentPageIndex: CGFloat = 0
    @State var CreateAccountShowing = false
    @State var isOutcomeShowing = false
    @State var isIncomeShowing = false
    @State var selectedAccount = Account()
    let backgroundColor = Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
    let isRegular = false
    
    var body: some View {
        
        VStack{
            
            //CreateAccount
            Button("계좌추가"){
                CreateAccountShowing.toggle()
            }
            .sheet(isPresented: $CreateAccountShowing){
                CreateAccountView(CreateAccountShowing: $CreateAccountShowing)
            }
            
            //Cards Scroll
            HStack{
                
                let totalAccount = self.accounts.count
                
                ForEach(accounts, id: \.self){  
                    account in
                                        
                    //Account Card
                    VStack{
                        HStack{
                            Text("\(account.name ?? "계좌")")
                                .fontWeight(.bold)
                                .font(.system(size:24))
                            Spacer()
                            Image(systemName: "trash")
                                .onTapGesture {
                                    AccountDataController().DeleteAccount(account: account, context: managedObjContext)
                                }
                        }
                        .padding()
                        Text("\(account.balance)")
                            .fontWeight(.bold)
                            .font(.system(size:24))
                        Spacer()
                        Divider()
                        HStack{
                            Text("지출")
                                .onTapGesture {
                                    isOutcomeShowing = true
                                    selectedAccount = account
                                }
                                .sheet(isPresented: $isOutcomeShowing){
                                    OutcomeView(isOutcomeShowing: $isOutcomeShowing, account: $selectedAccount)
                                }

                            Divider()
                            Text("수입")
                                .onTapGesture {
                                    isIncomeShowing = true
                                    selectedAccount = account
                                }
                                .sheet(isPresented: $isIncomeShowing){
                                    IncomeView(isIncomeShowing: $isIncomeShowing, account: $selectedAccount)
                                }
                        }
                        .padding(.horizontal, 50)
                        .frame(height: 75)
                    }
                    .frame(width: 270, height: 404)
                    .background(backgroundColor)
                    .cornerRadius(10)
                }
                .modifier(ScrollingHStackModifier(items: totalAccount, itemWidth: 270, itemSpacing: 10, currentPageIndex: $currentPageIndex))
            }
            .frame(width: 270, height: 404)
            .onAppear{
                currentPageIndex = CGFloat(accounts.count)
                print(currentPageIndex)
            }
            
            //Indicator
            HStack{

                let totalAccount = self.accounts.count
                
                ForEach(0..<totalAccount){
                    indicator in
                    Circle()
                        .fill(currentPageIndex == CGFloat(indicator) ? Color.black : Color.gray)
                        .frame(width: 4, height: 4)
                        .padding(4)
                }
            }
            .padding(.top,30)
            .environment(\.layoutDirection, isRegular ? .leftToRight : .rightToLeft)

        }
        //TabItem
        .tabItem{
            Image(systemName: "house")
            Text("메인")
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
