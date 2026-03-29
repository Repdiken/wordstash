# 🌟 Wordstash

A Flutter mobile app to **organize and learn words across multiple languages**. Users can create categories for different languages and add, edit, or delete words along with their translations. This is my midterm project for the User Interface Programming course with the professor [Deniz Dahman](https://www.linkedin.com/in/denizdahman/).


## 🔎 Research Problem

Learning vocabulary in multiple languages can be **disorganized and inefficient**. Existing solutions often require internet, have cluttered interfaces, or focus only on single languages. We all face the problem where we learn a new word and forget it easily. 

**Wordstash solves these problem** by providing a **simple, offline-friendly, and customizable vocabulary manager** where users can organize words into categories and track their learning.


## 💡 Motivation

- **Efficiency:** Helps learners focus on specific words and practice frequently.  
- **Organization:** Categories for each language prevent confusion.  
- **Simplicity:** Lightweight and easy to use with a clean interface.  
- **Offline Access:** Users can access and edit vocabulary anytime, without internet.


## 🔄 Control Flow

**Step by Step:**

1. **Launch App** → opens **CategoryPage**.  
2. **Add Category** → click “+” → enter language name → save.  
3. **View Categories** → categories appear as colored cards.  
4. **Edit/Delete Category** → use edit or delete buttons.  
5. **Select a Category** → navigate to **WordPage**.  
6. **Add Word** → click “+” → enter word + translation → save.  
7. **Edit/Delete Word** → edit or delete via buttons.  
8. **Return** → back to **CategoryPage**.  
9. **UI Updates** automatically via `setState()`.

**Flow Diagram:**

```
[App Launch]
    |
    v
[CategoryPage] --- Add/Edit/Delete --> [Categories List]
    |
    v
[WordPage] ---- Add/Edit/Delete --> [Words List]
    |
    v
Back to [CategoryPage]
```

## 🔨 Implementation Strategy

**Project Structure:**

```
lib/
 ├── main.dart           # Entry point + home page (CategoryPage) + data models
 └── category_page.dart  # Inside a category (WordPage: words & translations)
```


**Logic & Modules**

1. **Models**
   - `Category` → stores language name and a list of words.
   - `Word` → stores word text and translation.
2. **CategoryPage**
   - Displays a dynamic list of categories.
   - `FloatingActionButton` triggers adding a new category.
   - `_addOrEditCategory` handles both adding and editing via `AlertDialog`.
   - Edit/delete buttons on each category card.
3. **WordPage**
   - Receives a `Category` object.
   - Displays the words of that category.
   - `_addOrEditWord` handles adding/editing words with two text fields (word + translation).
   - Edit/delete buttons on each word card.
4. **UI**
   - Material Design (`Scaffold`, `AppBar`, `Card`, `ListTile`) for clean layout.
   - Different colored cards for categories and words.
   - `setState()` ensures UI updates immediately after data changes.
5. **Navigation**
   - `Navigator.push()` moves from CategoryPage → WordPage.
   - Back button returns to CategoryPage.


## ✅ Summary

Wordstash is a **lightweight, offline Flutter app** to help language learners **organize vocabulary efficiently**.