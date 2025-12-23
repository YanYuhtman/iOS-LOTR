//
//  Currency_SelectorView.swift
//  LOTR
//
//  Created by Yan  on 20/12/2025.
//

import SwiftUI

struct CurrencySelectorView: View {
    let cTypes = CurrencyType.allCases
    
    @ObservedObject var modelView:CurrencyViewModel
    @Environment(\.dismiss) var dismiss
    
    func OnItemTapped()->Void{
        dismiss()
    }
    
    var body: some View {
        ZStack{
            Image(.parchment)
                .resizable()
                .offset(y: 40)
            VStack{
                VStack{
                    Text("Select FROM converion")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black).opacity(0.8)
                    ItemsView(currencyType: $modelView.leftCurrencyType,onItemTapped: OnItemTapped)
                }
                .padding(.bottom,40)
                
                VStack{
                    Text("Select TO converion")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black).opacity(0.8)
                    ItemsView(currencyType:  $modelView.rightCurrencyType,onItemTapped: OnItemTapped)
                }
            }
        }
    }
}
struct ItemsView : View {
    let cTypes = CurrencyType.allCases
    @Binding var currencyType:CurrencyType
    var onItemTapped:()->Void
    
    var body: some View {
        let rows = [
            GridItem(.fixed(100)),
            GridItem(.fixed(100)),
        ]
        LazyHGrid(rows: rows, spacing: 10){
            ForEach(0..<cTypes.count,id: \.self){index in
                ItemView(currencyItemType:cTypes[index], selectedType: $currencyType, onItemTapped: onItemTapped)
            }
        }
    }
}
struct ItemView : View {
    var currencyItemType: CurrencyType
    @Binding var selectedType: CurrencyType
    var onItemTapped:()->Void
    
    var body: some View{
        ZStack(alignment: .bottom){
            Image(currencyItemType.image)
                
                .resizable()
                .scaledToFit()
                .padding(5)
                .shadow(radius: 4)
        
            Text(currencyItemType.name)
                .font(.caption2.bold())
                .foregroundColor(.black.opacity(0.65))
                .shadow(radius: 2)
                .padding(10)
                .padding(.top, -8)
                .background(Color.brown)
                .padding(.bottom,2)

        }
                .frame(width: 100, height: 100)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black,lineWidth: selectedType == currencyItemType ? 3 : 0)
                .fill(Color.brown)
        }
        .onTapGesture {
            selectedType = currencyItemType
            onItemTapped()
        }



    }
}

func onCurrencySelected(fromCurrency:CurrencyType?,toCurrency:CurrencyType?){
    if(fromCurrency == nil || toCurrency == nil){
        return
    }
    
}

#Preview {
    CurrencySelectorView(modelView: CurrencyViewModel())
}

#Preview {
    HStack{
        ItemView(currencyItemType:.SilverPenny, selectedType: Binding.constant(.CopperPenny), onItemTapped: {
            print("Item tapped")
        })
        
    }.padding(100)
        .background(Color.white)
//        .preferredColorScheme(.light)
}
