//
//  CustomDropdownMenu.swift
//  CustomDropdownMenu
//
//  Created by Everton Carneiro on 05/02/22.
//

import SwiftUI

struct CustomDropdownMenu: View {
    @State var isSelecting = false
    @State var selectionTitle = ""
    @State var selectedRowId = 0

    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    Text(selectionTitle)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .animation(.none)
                    Spacer()
                    Image(systemName: "chevron.down")
                    .font(.system(size: 16, weight: .semibold))
                    .rotationEffect(.degrees( isSelecting ? -180 : 0))

                }
                .padding(.horizontal)
                .foregroundColor(.white)
                
                if isSelecting {
                    Divider()
                        .background(.white)
                        .padding(.horizontal)

                    VStack(spacing: 5) {
                        DropdownMenuItemView(isSelecting: $isSelecting, selectionId: $selectedRowId, selectiontitle: $selectionTitle, item: .init(id: 1, title: "Messages", iconImage: Image(systemName: "envelope"), onSelect: {}))
                        DropdownMenuItemView(isSelecting: $isSelecting, selectionId: $selectedRowId, selectiontitle: $selectionTitle, item: .init(id: 2, title: "Archived", iconImage: Image(systemName: "archivebox"), onSelect: {}))
                        DropdownMenuItemView(isSelecting: $isSelecting, selectionId: $selectedRowId, selectiontitle: $selectionTitle, item: .init(id: 3, title: "Trash", iconImage: Image(systemName: "trash"), onSelect: {}))
                    }
                }

            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(Color(uiColor: UIColor.systemIndigo))
            .cornerRadius(5)
            .onTapGesture {
                isSelecting.toggle()
            }
            .onAppear {
                selectedRowId = 1
                selectionTitle = "Messages"
            }
            .animation(.easeInOut(duration: 0.3))
        }
    }
}

struct DropdownItem: Identifiable {
    let id: Int
    let title: String
    let iconImage: Image
    let onSelect: () -> Void
}

struct DropdownMenuItemView: View {
    @Binding var isSelecting: Bool
    @Binding var selectionId: Int
    @Binding var selectiontitle: String
    
    let item: DropdownItem

    var body: some View {
        Button(action: {
            isSelecting = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                selectionId = item.id
            }
            selectiontitle = item.title
            item.onSelect()
        }) {
            HStack {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .opacity(selectionId == item.id ? 1 : 0)
                Text(item.title)
                    .font(.system(size: 16, weight: .regular, design: .rounded))

                Spacer()
                item.iconImage
            }
            .padding(.horizontal)
            .foregroundColor(.white)

        }
    }
}

struct CustomDropdownMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomDropdownMenu()
            .padding(.horizontal)
    }
}
