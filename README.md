# Dart String Utility Application

A simple command-line Dart application that performs string manipulation, demonstrates the use of Dart collections, handles file I/O, and uses date/time formatting to log user inputs.

---

## 🚀 Features

- 🔤 **String Manipulation**
  - Concatenation, interpolation
  - Case conversion (upper/lower)
  - Reversal and trimming
  - Custom formatting (capitalize, reverse, etc.)

- 📚 **Collections**
  - Uses List to store entries
  - Demonstrates Set and Map usage (in demo functions)

- 📂 **File Handling**
  - Reads from `entries_log.txt`
  - Appends new data without overwriting
  - Handles file read/write errors gracefully

- 🕓 **Date and Time**
  - Logs entry timestamps
  - Displays how long ago each entry was made
  - Formats timestamps using the `intl` package

---

## 📦 Requirements

- Dart SDK >=2.17.0
- `intl` package

---

## 🛠 Setup Instructions

1. **Clone or download the project.**

2. **Create the `pubspec.yaml` file** if it's not already present:

    ```yaml
    name: string_util_app
    description: A simple Dart utility app for string manipulation, file handling, and date-time logging.
    version: 1.0.0

    environment:
      sdk: '>=2.17.0 <4.0.0'

    dependencies:
      intl: ^0.18.1
    ```

3. **Install dependencies:**

    ```bash
    dart pub get
    ```

4. **Run the app:**

    ```bash
    dart run main.dart
    ```

---

## 📁 File Structure

