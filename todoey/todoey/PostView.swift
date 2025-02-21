import SwiftUI

struct Todo1: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}

struct PostView: View {
    @State private var todos: [Todo1] = [
        Todo1(item: "Finish homework", isDone: false),
        Todo1(item: "Complete Project 3", isDone: true)
    ]
    @State private var newTodoItem: String = ""

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)  // Black background

            VStack(alignment: .leading) {
                // App Title
                Text("Todoey")
                    .foregroundColor(.yellow)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.leading, 20)

                // Todo List
                List {
                    ForEach($todos) { $todo1 in
                        HStack {
                            // Circle Button to toggle completion
                            Button {
                                todo1.isDone.toggle()
                            } label: {
                                Image(systemName: todo1.isDone ? "circle.fill" : "circle")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }

                            // Todo Item Text
                            Text(todo1.item)
                                .foregroundColor(.white)
                                .font(.title2)
                                .opacity(todo1.isDone ? 0.5 : 1)
                        }
                        .padding(.vertical, 5)
                        .listRowBackground(Color.black)  // Black row background
                    }
                    .onDelete(perform: deleteTodo)
                }
                .listStyle(PlainListStyle())  // Clean list without separators
                .background(Color.black)

                // New Reminder Button
                HStack {
                    TextField("Enter new reminder", text: $newTodoItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)

                    Button {
                        addNewTodo()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.yellow)
                            Text("New Reminder")
                                .foregroundColor(.yellow)
                                .font(.title2)
                                .bold()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .preferredColorScheme(.dark)
    }

    // Function to add a new todo item
    private func addNewTodo() {
        guard !newTodoItem.isEmpty else { return }
        todos.append(Todo1(item: newTodoItem, isDone: false))
        newTodoItem = ""
    }

    // Function to delete a todo item
    private func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

#Preview {
    PostView()
        .preferredColorScheme(.dark)
}
