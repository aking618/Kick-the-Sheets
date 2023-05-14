//
//  SettingsView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/9/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel = SettingsViewModel()
    
    @ViewBuilder
    private var header: some View {
        Text("Settings")
            .ktcFont(.title2)
            .foregroundColor(KTSColors.textColor.color)
            .padding()
        
    }
    
    @ViewBuilder
    private var options: some View {
        VStack(spacing: 5){
            List(viewModel.options) { option in
                    HStack{
                        Image(systemName: option.image)
                        Text(option.title)
                            .foregroundColor(KTSColors.textColor.color)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
    
    var body: some View {
        BaseView {
            VStack {
                header
                options
            }
        }
        .foregroundColor(KTSColors.textColor.color)
        .onAppear {
            viewModel.setup()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
