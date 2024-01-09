//
//  OrderView.swift
//  HackingSwiftLearn
//
//  Created by Fatih Kenarda on 9.01.2024.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order : Order
    
    var body: some View {
        NavigationStack{
            List{
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: { indexSet in
                        order.items.remove(atOffsets: indexSet)
                    })
                }
                Section{
                    NavigationLink("Place Order"){
                        CheckoutAdvencedView()
                    }
                }
            }
            .navigationTitle("Order")
        }
    }
}

struct OrderView_Previews : PreviewProvider{
    static var previews: some View{
        OrderView().environmentObject(Order().dummyInit())
    }
}
