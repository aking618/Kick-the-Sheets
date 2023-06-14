//
//  View+Popup.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/18/23.
//

import PopupView
import SwiftUI

extension View {
    @ViewBuilder
    func aboutPagePopup(_ shouldShow: Binding<Bool>) -> some View {
        alert(isPresented: shouldShow) {
            Alert(
                title: Text(AboutStrings.title.rawValue),
                message: Text(AboutStrings.message.rawValue),
                dismissButton: .cancel()
            )
        }
    }

    @ViewBuilder
    func deleteAllDataAlert(_ shouldShow: Binding<Bool>, viewModel: ContentViewModel) -> some View {
        alert(isPresented: shouldShow) {
            Alert(
                title: Text("Delete All Data"),
                message: Text("Are you sure you want to delete all of your data?"),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Delete"), action: {
                    TodoDataStore.shared.deleteAllEntries()
                    viewModel.update()
                })
            )
        }
    }

    @ViewBuilder
    func addTodoPopup(
        _ isPresented: Binding<Bool>,
        dayId: Int64,
        todos: Binding<[Todo]>,
        errorPopup: Binding<Bool>
    ) -> some View {
        popover(isPresented: isPresented) {
            AddTodoSheetView(
                dayId: dayId,
                todos: todos,
                showPopup: isPresented,
                errorPopup: errorPopup
            )
        }
    }

    @ViewBuilder
    func errorPopup(_ shouldShow: Binding<Bool>) -> some View {
        popup(isPresented: shouldShow) {
            Text("New todos cannot be blank")
                .ktsFont(.body)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 60, leading: 32, bottom: 16, trailing: 32))
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FE504E"))
        } customize: {
            $0
                .type(.toast)
                .position(.top)
                .animation(.easeInOut)
                .closeOnTapOutside(true)
                .autohideIn(3)
        }
    }
}
