//
//  ContentView.swift
//  LOTR
//
//  Created by Yan  on 19/12/2025.
//

import SwiftUI


class CurrencyViewModel : ObservableObject{
    
    @Published var leftCurrencyValue:String = "" {
        didSet{
            updateConversion(leftCurrencyValue,true)
        }
    }
    @Published var rightCurrencyValue:String = "" {
        didSet{
            updateConversion(rightCurrencyValue,false)
        }
    }
        
    @Published var leftCurrencyType = CurrencyType.GoldPiece {
        didSet{
            updateConversion(leftCurrencyValue,true)
        }
    }
    @Published var rightCurrencyType = CurrencyType.CopperPenny{
        didSet{
            updateConversion(rightCurrencyValue,false)
        }
    }
    
    private var _lockConversion = false
    private func updateConversion(_ from:String,_ isLeft:Bool){
        if(_lockConversion){
            return
        }
        if let _from = Double(from){
            
            _lockConversion = true
            if(isLeft){
                rightCurrencyValue = leftCurrencyType.convertToString(_from, to:rightCurrencyType)
            }else {
                leftCurrencyValue = rightCurrencyType.convertToString(_from, to:leftCurrencyType)
            }
            _lockConversion = false
        }
        
    }
}


struct ContentView: View {
    @StateObject var modelView = CurrencyViewModel()
    @State var isInfoPresented = false
    @FocusState private var isFocused
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Text("Currency exchange")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                HStack{
                    CurrencyFieldView(alignment: .leading, modelView: modelView,isLeft: true)
                    CurrencyFieldView(alignment: .trailing, modelView: modelView,isLeft: false)
                }
                
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                            .fill(Color.black)
                            .shadow(radius: 4, x: 10, y: 10)
                            .opacity(0.4)
                        
                            
                    ).frame(width: .infinity)
                    
                    
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isInfoPresented = true
                    }){
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                            .foregroundColor(.white)
                        
                    }.padding(.trailing, 10)
                }
            }.sheet(isPresented: $isInfoPresented){
                InfoView()
                    .background(Color.black.opacity(0.8)) // dim background
            }
            
        }
        .onTapGesture {
            hideKeyBoard()
        }
    }
    func hideKeyBoard(){
        UIApplication.shared.sendAction(
                   #selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil
               )
    }
}
struct CurrencyFieldView:View {
    let alignment: HorizontalAlignment
    @ObservedObject var modelView:CurrencyViewModel
    var isLeft:Bool
    
    @State var isCurrencySelectorPresented = false
    func getImage()->AnyView{
        AnyView(Image(isLeft ? modelView.leftCurrencyType.image : modelView.rightCurrencyType.image )
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .onTapGesture {
                isCurrencySelectorPresented = true
            }
        )
    }
    
    func getImageTitle()->AnyView{
        AnyView(Text(isLeft ? modelView.leftCurrencyType.name : modelView.rightCurrencyType.name)
            .foregroundStyle(.white))
    }
    
    
    var body: some View {
        VStack(alignment: alignment){
            HStack{
                if(alignment == .leading){
                    getImage()
                    getImageTitle()
                }else {
                    getImageTitle()
                    getImage()
                }
                
            }
            TextField("",text: (isLeft ? $modelView.leftCurrencyValue : $modelView.rightCurrencyValue))
            .font(.title3.bold())
            .textFieldStyle(.roundedBorder)
            .environment(\.colorScheme,.light)
            .frame(maxWidth: 140)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(alignment == .leading ? .leading : .trailing)
        }
        .sheet(isPresented: $isCurrencySelectorPresented){
            CurrencySelectorView(modelView: modelView)
        }
    }
   
}

#Preview {
    ContentView()
        
}
