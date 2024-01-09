//
//  CompainsListRowView.swift
//  HackingSwiftLearn
//
//  Created by Fatih Kenarda on 5.01.2024.
//

import SwiftUI


struct CompainsListRowView : View {
    private let menuItem : [MenuSection]
    
    init() {
        menuItem = Bundle.main.decode([MenuSection].self, from: "menu.json")
    }
    var body: some View {
        NavigationView {
            List{
                ForEach(menuItem) { section in
                    Section {
                        ForEach(section.items) { item in
                            NavigationLink{
                                ItemDetailView(item: item)
                            }label: {
                                ItemRow(item: item)
                            }
                        }
                    } header: {
                        Text(section.name)
                    } footer: {
                        Text("Count \(section.items.count.description)")
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }

    }
}

struct CompainsListRowView_Previews : PreviewProvider{
    static var previews: some View{
        CompainsListRowView()
    }
}


struct ItemRow: View {
    let item : MenuItem
    var body: some View {
        
        HStack {
            Image(item.thumbnailImage)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(.gray, lineWidth: 2))
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                HStack {
                    Text("\(item.price)$")
                    
                    Spacer()
                    ForEach(item.restrictions, id: \.self) { restriction in
                        Text(restriction)
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(RestrictionColor.color(value : restriction))
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                    }
                }
            }
            
        }
    }
}

private enum RestrictionColor: String {
    case D
    case G
    case N
    case S
    case V
    
    static func color(value: String) -> Color{
        switch value {
        case RestrictionColor.D.rawValue:
            return Color.purple
        case RestrictionColor.G.rawValue:
            return Color.black
        case RestrictionColor.N.rawValue:
            return Color.red
        case RestrictionColor.S.rawValue:
            return Color.blue
        case RestrictionColor.V.rawValue:
            return Color.green
        default:
            return Color.black
        }
    }
}
