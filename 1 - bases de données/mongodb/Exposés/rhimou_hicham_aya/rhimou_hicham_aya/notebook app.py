import tkinter as tk
from tkinter import messagebox
from tkinter import scrolledtext

from datetime import datetime

from pymongo import MongoClient

# Connection to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["notebook"]
collection = db["notes"]

# Create an index on the title field
db.notes.create_index([("title", "text")])

# Add a note
def add_note():
    title = entry_title.get()
    content = text_content.get("1.0", tk.END).strip()

    if title and content:
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        note = {"title": title, "content": content, "timestamp": current_time}
        collection.insert_one(note)
        messagebox.showinfo("Note Added", "Note added successfully.")
        update_note_list()
        entry_title.delete(0, tk.END)
        text_content.delete("1.0", tk.END)
    else:
        messagebox.showwarning("Add Note", "Please enter both title and content.")

# Update the note list with optional search
def update_note_list(search_text=None):
    note_listbox.delete(0, tk.END)
    
    if search_text:
        # Use text search if search_text is provided
        notes = collection.find({"$text": {"$search": search_text}})
    else:
        notes = collection.find()

    for note in notes:
        note_listbox.insert(tk.END, f"{note['title']}")

# View selected note
def view_selected_note(event):
    selected_note_index = note_listbox.curselection()
    if selected_note_index:
        selected_note_index = selected_note_index[0]
        selected_note_title = note_listbox.get(selected_note_index)
        
        # Check if the selected note title exists in the filtered list
        if selected_note_title in [f"{note['title']}" for note in collection.find()]:
            selected_note = collection.find_one({"title": selected_note_title})
            entry_title.delete(0, tk.END)
            entry_title.insert(0, selected_note["title"])
            text_content.delete("1.0", tk.END)
            text_content.insert("1.0", selected_note["content"])
        else:
            messagebox.showwarning("Note Not Found", "The selected note is not present in the filtered list.")

# Modify a note
def modify_note():
    selected_note_index = note_listbox.curselection()
    if selected_note_index:
        selected_note_index = selected_note_index[0]
        selected_note = collection.find()[selected_note_index]
        modified_title = entry_title.get()
        modified_content = text_content.get("1.0", tk.END).strip()

        if modified_title and modified_content:
            collection.update_one({"_id": selected_note["_id"]}, {"$set": {"title": modified_title, "content": modified_content}})
            messagebox.showinfo("Note Modified", "Note modified successfully.")
            update_note_list()
        else:
            messagebox.showwarning("Modify Note", "Please enter both title and content.")
    else:
        messagebox.showwarning("Modify Note", "Please select a note to modify.")

# Delete a note
def delete_note():
    selected_note_index = note_listbox.curselection()
    if selected_note_index:
        selected_note_index = selected_note_index[0]
        selected_note = collection.find()[selected_note_index]
        collection.delete_one({"_id": selected_note["_id"]})
        messagebox.showinfo("Note Deleted", "Note deleted successfully.")
        update_note_list()
        entry_title.delete(0, tk.END)
        text_content.delete("1.0", tk.END)
    else:
        messagebox.showwarning("Delete Note", "Please select a note to delete.")

# Create the main window
root = tk.Tk()
root.title("Notebook")

# Set the window size
root.geometry("600x400")

# Create a frame for styling
style_frame = tk.Frame(root)
style_frame.place(relx=0.5, rely=0.5, anchor="center")

# Entry field for note title
label_title = tk.Label(style_frame, text="Title:", font=("Helvetica", 12))
label_title.grid(row=0, column=0, pady=5, padx=10, sticky="w")

entry_title = tk.Entry(style_frame, width=30, font=("Helvetica", 12))
entry_title.grid(row=0, column=1, pady=5, padx=10)

# Text widget for note content
label_content = tk.Label(style_frame, text="Content:", font=("Helvetica", 12))
label_content.grid(row=1, column=0, pady=5, padx=10, sticky="w")

text_content = scrolledtext.ScrolledText(style_frame, height=5, width=30, font=("Helvetica", 12))
text_content.grid(row=1, column=1, pady=5, padx=10)

# Buttons for add, view, modify, and delete notes
button_add_note = tk.Button(style_frame, text="Add Note", command=add_note, font=("Helvetica", 12))
button_add_note.grid(row=2, column=0, pady=10)

button_view_notes = tk.Button(style_frame, text="View Notes", command=lambda: update_note_list(), font=("Helvetica", 12))
button_view_notes.grid(row=2, column=1, pady=10)

button_modify_note = tk.Button(style_frame, text="Modify Note", command=modify_note, font=("Helvetica", 12))
button_modify_note.grid(row=3, column=0, pady=10)

button_delete_note = tk.Button(style_frame, text="Delete Note", command=delete_note, font=("Helvetica", 12))
button_delete_note.grid(row=3, column=1, pady=10)

# Entry field for search
label_search = tk.Label(style_frame, text="Search:", font=("Helvetica", 12))
label_search.grid(row=4, column=0, pady=5, padx=10, sticky="w")

entry_search = tk.Entry(style_frame, width=30, font=("Helvetica", 12))
entry_search.grid(row=4, column=1, pady=5, padx=10)

button_search = tk.Button(style_frame, text="Search", command=lambda: update_note_list(entry_search.get()), font=("Helvetica", 12))
button_search.grid(row=4, column=2, pady=5)

# Listbox to display notes
note_listbox = tk.Listbox(style_frame, selectmode=tk.SINGLE, font=("Helvetica", 12))
note_listbox.grid(row=5, column=0, columnspan=2, pady=10)

# Bind the view_selected_note function to the listbox selection event
note_listbox.bind("<<ListboxSelect>>", view_selected_note)

# Run the GUI application
root.mainloop()
