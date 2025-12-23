//
//  TestView.swift
//  LOTR
//
//  Created by Yan  on 19/12/2025.
//
import SwiftUI



struct IntoTextModifier:ViewModifier{
   
    func body(content: Content) -> some View {
            content
            .foregroundStyle(.black)
            .opacity(0.6)
        }
}

struct InfoView: View{
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
       
        
        ZStack{
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .padding(EdgeInsets(top: 0, leading: -5, bottom: -40, trailing: -5))
                

            VStack{
                Text("Exchange Rates")
                    .font(.largeTitle.bold())
                    .modifier(IntoTextModifier())
                    
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.headline)
                    .modifier(IntoTextModifier())
                
                let allC = CurrencyType.allCases
                ForEach(0..<allC.count - 1,id:\.self,content: {index in
                    CurrencyInfo(fromCurrncry: allC[index],toCurrencty: allC[index + 1])
                       
                })
                    
            }.padding()
              
        }.onTapGesture(){
            dismiss()
        }
    }
}
struct CurrencyInfo: View{
    var fromCurrncry:CurrencyType
    var toCurrencty:CurrencyType
    
    var body: some View {
        HStack{
            Image(fromCurrncry.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            Text("1 \(fromCurrncry.name) = \(Int(fromCurrncry.convert(1, to: toCurrencty).rounded())) \(toCurrencty.getName(true))")
                    .modifier(IntoTextModifier())
                    .frame(maxWidth:.infinity)
                
            Image(toCurrencty.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
        }.padding(.leading,5)
         .padding(.trailing,5)
            
    }
}
#Preview(){
    InfoView()
}

#Preview(){
    CurrencyInfo(fromCurrncry: .GoldPenny, toCurrencty: .CopperPenny)
        .background(.yellow)
}

func testGit(){
    //Check
    //Check 2
}
