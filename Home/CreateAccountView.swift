//
//  CreateCardView.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/20.
//

import SwiftUI

struct CreateAccountView: View {

    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var balance = 0
    
    @Binding var CreateAccountShowing: Bool
    
    var body: some View {
        Form{
            Section{
                TextField("계좌이름", text:  $name)
                TextField("잔액", value: $balance, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                Button("Submit"){
                    AccountDataController()
                        .CreateAccount(
                            name: name,
                            balance: Int64(balance),
                            context: managedObjContext
                        )
                    CreateAccountShowing.toggle()
                }
            }
            Button("돌아가기"){
                CreateAccountShowing.toggle()
            }
        }
    }
}

//struct CreateCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateCardView()
//    }
//}
