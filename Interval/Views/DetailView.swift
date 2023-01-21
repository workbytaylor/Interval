//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert: Bool = false
    @State var showEditView: Bool = false
    
    var body: some View {
        VStack(spacing: .zero) {
            List {
                ForEach((1...3), id: \.self) { step in
                    HStack {
                        /*
                        Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                            .frame(width: 40)
                        */
                         VStack(alignment: .leading) {
                            Text("magnitude")+Text("unit")
                            Text("Pace")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .background(Color(red: 242/255, green: 241/255, blue: 247/255))
        .navigationBarTitle("Title")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    
                    Divider()
                    
                    Button {
                        showEditView.toggle()
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditView(vm: .init(provider: .shared)/*workout: workout*/)
        }
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
}

/*
struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView()
    }
}
*/
