//
//  OutcomeView.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/20.
//

import SwiftUI

struct OutcomeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State var amount = 0
    @Binding var isOutcomeShowing: Bool
    @Binding var account: Account
    
    var body: some View {
        VStack{

            //금액
            HStack{
                Text("금액")
                    .font(
                        .system(
                            size: 21,
                            weight: .bold
                            )
                    )
                Spacer()
            }
            
            //금액 입력
            TextField("금액", value: $amount, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
            
            //완료
            Button("Submit"){
                AccountDataController()
                    .LogOutcome(
                        account : account,
                        amount : Int64(amount),
                        context: managedObjContext
                    )
                isOutcomeShowing.toggle()
            }
            
            //Dismiss
            Button("Dismiss"){
                    isOutcomeShowing = false
            }
        }
        .padding(.horizontal, 20)
    }
}
//
//struct OutcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutcomeView()
//    }
//}
