import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}

struct ContentView: View {
    // Replace with todos @State variable
    @State private var todos: [Todo] = []
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                Text("Todoey")
                    .foregroundStyle(Color.yellow)
                    .font(.system(size: 40, weight: .bold))
                    .offset(x: 30)
                
                List {
                    ForEach($todos) { $todo in
                        HStack {
                            Button {
                                todo.isDone.toggle()
                            } label: {
                                Image(systemName: todo.isDone ? "circle.fill" : "circle")
                                    .padding(.horizontal, 10)
                                    .foregroundStyle(Color.yellow)
                                    .font(.title2)
                            }
                            TextField("", text: $todo.item)
                                .foregroundColor(.white)
                                .font(.title2)
                                .opacity(todo.isDone ? 0.5 : 1)
                        }
                    }
                    .onDelete(perform: removeRows)
                }
                .listStyle(PlainListStyle())
                    
                Button {
                    todos.append(Todo(item: "", isDone: false)) } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.yellow)
                            Text("New Reminder")
                                .foregroundColor(.yellow)
                                .font(.title2)
                                .bold()
                            }
                    }
                        .offset(x: 30)
            }

        }
        
    }
func removeRows(at offsets: IndexSet) {
    todos.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
