//
//  ItemDetail.swift
//  HackingSwiftLearn
//
//  Created by Fatih Kenarda on 6.01.2024.
//

import SwiftUI

struct ItemDetailView: View {
    let item : MenuItem
    @EnvironmentObject var order : Order
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing)
            {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5,y: -5)
            }
            Text(item.description)
                .padding()
            
            Button("Order This"){
                order.add(item: item)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetailView_Previews : PreviewProvider{
    static var previews: some View{
        NavigationStack{
            ItemDetailView(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}

