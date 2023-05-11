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
        
    }
    
    @ViewBuilder
    private var options: some View {
        VStack(spacing: 5){
            ForEach(viewModel.options) { option in
                    HStack{
                        Image(systemName: option.image)
                        Text(option.title)
                            .foregroundColor(KTSColors.textColor.color)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(KTSColors.background.color)
            }
        }
    }
    
    var body: some View {
        BaseView {
            VStack {
                header
                options
            }
        }
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
