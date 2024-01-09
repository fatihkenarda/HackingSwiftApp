//
//  CheckoutAdvencedView.swift
//  HackingSwiftLearn
//
//  Created by Fatih Kenarda on 7.01.2024.
//

import SwiftUI

struct CheckoutAdvencedView: View {
    @State private var paymentType : PaymentType = .cash
    @State private var amountType : AmountType = .fifteen
    @State private var addLoyaltyDetails : Bool = false
    @State private var loyaltyNumber = ""
    @State private var amount = ""
    @State private var isAlertVisible = false
    
@EnvironmentObject var order : Order
    
    private func checkValidation () -> Bool{
        if amountType == .zero || loyaltyNumber.isEmpty{
            return false
        }
        return true
    }
    
    private var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(amountType.rawValue)
        return (total - tipValue).formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Picker("How do you want to pay", selection: $paymentType){
                        ForEach(PaymentType.allCases, id: \.self) { item in
                            Text(item.rawValue)
                                .padding(.all)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails)
                    if addLoyaltyDetails {
                        TextField("Enter your iDine ID", text: $loyaltyNumber)
                    }
                }
                Section("Add a tip ?"){
                    Picker("Tips", selection: $amountType){
                        ForEach(AmountType.allCases, id: \.self) { item in
                            Text("\(item.rawValue.description)%")
                                .padding(.all)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    List{
                        ForEach(order.items) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("$\(item.price)")
                            }
                        }.onDelete(perform: { indexSet in
                            order.items.remove(atOffsets: indexSet)
                        })
                    }.toolbar{
                        EditButton()
                    }
                }
                
                Spacer()
                Button{
                    isAlertVisible.toggle()
                }
                label: {
                    Text("Complete \(totalPrice)")
                }.disabled(!checkValidation())
                .pickerStyle(.menu)
                Spacer()
                .navigationTitle("Payment")
            }
        }
        .padding(.all)
        .alert("Hello", isPresented: $isAlertVisible){
        }
        message : {
            Text("Your total was \(totalPrice) Thank You.")
        }
 
    }
}

struct CheckoutAdvencedView_Previews : PreviewProvider{
    static var previews: some View{
        CheckoutAdvencedView().environmentObject(Order().dummyInit())
    }
}


enum PaymentType: String, CaseIterable {
    case cash = "Cash"
    case creditCard = "Credit Card"
    case idinePoints = "Idine Points"
}

enum AmountType: Int, CaseIterable {
    case ten = 10
    case fifteen = 15
    case twenty = 20
    case twentyFive = 25
    case zero = 0
}

    
