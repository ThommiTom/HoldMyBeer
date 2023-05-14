//
//  CommonPropertiesView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct CommonPropertiesView: View {
    @State private var common: CommonProperties
    
    init(common: CommonProperties) {
        _common = State(initialValue: common)
    }
    
    @State private var showAlert = false
    
    let pickerChoice: [Inequality] = [.greaterThan, .lessThan]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 20) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(.secondary)
                        .opacity(0.75)
                }
                .alert(common.title, isPresented: $showAlert) {} message: {
                    VStack {
                        Text(common.description)
                    }
                }
                
                Text(common.title)
                Spacer()
                
                Toggle("Toggle", isOn: $common.toggle)
                    .labelsHidden()
                    .onChange(of: common.toggle) { newValue in
                        if newValue {
                            let _ = URLBuilder.shared.addQueryItem(for: common.setInequality, common.value)
                        } else {
                            let _ = URLBuilder.shared.removeQueryItem(for: common.setInequality)
                        }
                    }
            }
            
            if common.toggle {
                VStack(alignment: .center) {
                    Text("\(common.inequality.rawValue) \(common.value, specifier: "%0.1f") %")
                        .font(.title3)
                        .bold()
                        .padding(.top, 3)
                    
                    Picker("Inequality", selection: $common.inequality) {
                        ForEach(pickerChoice) {
                            Text($0.rawValue)
                        }
                    }
                    .onChange(of: common.inequality, perform: { newValue in
                        let _ = URLBuilder.shared.addQueryItem(for: common.setInequality, common.value)
                    })
                    .pickerStyle(.segmented)
                    .padding(.vertical, 3)
                    
                    Slider(value: $common.value, in: common.min...common.max, step: common.step) {
                        Text(String(common.value))
                    }
                    .onChange(of: common.value) { newValue in
                        let _ = URLBuilder.shared.addQueryItem(for: common.setInequality, common.value)
                    }
                }
                

            }
        }
    }
}

struct CommonPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        CommonPropertiesView(common: ABV())
    }
}
