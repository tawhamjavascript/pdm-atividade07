//
//  FormView.swift
//  pratica07
//
//  Created by Taw-ham Balbino on 12/12/23.
//

import SwiftUI

struct FormView: View {
    @State var nome: String = ""
    @State var modelo: String = ""
    @State var ano: Int16 = 0
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    var carro: Carro?
 
    
    var body: some View {
        VStack{
            formulario
                .navigationTitle("Formulário")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem{
                        Button("Salvar") {
                            if (self.carro != nil) {
                                self.carro?.nome = self.nome
                                self.carro?.modelo = self.modelo
                                self.carro?.ano = self.ano
                            }
                            else {
                                let carro = Carro(context: viewContext)
                                carro.nome = self.nome
                                carro.modelo = self.modelo
                                carro.ano = self.ano
                                print("salvando")
                            }
                            
                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                }
        }.onAppear() {
            self.ano = self.carro?.ano ?? 0
            self.modelo = self.carro?.modelo ?? ""
            self.nome = self.carro?.nome ?? ""
        }
    }
}

extension FormView {
    var formulario: some View {
        Form {
            Section("Nome") {
                TextField("Informe o nome do carro", text:self.$nome)
            }
            
            Section("Modelo") {
                TextField("Informe o modelo do carro", text:self.$modelo)
            }
            
            Section("Ano") {
                TextField("Informe o ano do carro", text:Binding<String>(
                    get: { String(self.ano) },
                    set: { if let value = Int16($0) { self.ano = value } }
                ))
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
  
    static var previews: some View {
        FormView()
    }
}
