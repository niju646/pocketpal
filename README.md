# 💰 Pocket Pal

A simple and clean **personal money management application** built with Flutter.

Pocket Pal helps you keep track of your **income, expenses, balance, and spending categories** in one place.

> 🚧 This project is currently under development.

---

## 📱 About

Pocket Pal is a personal finance tracking app designed to make everyday money management simple.

The application focuses on:

* Tracking income
* Tracking expenses
* Monitoring available balance
* Categorizing expenses
* Viewing recent transactions
* Managing personal profile information

The initial version is designed to work with **local storage**, without requiring a backend server.

---

## ✨ Features

### 🏠 Dashboard

* Total income
* Total expenses
* Current balance
* Recent transactions
* Current month overview
* Quick transaction button

### 💵 Income

Add income transactions with:

* Amount
* Category
* Date
* Description

### 💸 Expenses

Track expenses with:

* Amount
* Category
* Date
* Description

### ➕ Add Transaction

A reusable bottom sheet is used for both income and expenses.

```text
┌─────────────────────────────┐
│      Add Transaction        │
│                             │
│  ┌──────────┬───────────┐   │
│  │  Income  │  Expense  │   │
│  └──────────┴───────────┘   │
│                             │
│  Amount                     │
│  Category                   │
│  Date                       │
│  Description                │
│                             │
│      [ Add Income ]         │
└─────────────────────────────┘
```

The selected tab determines whether the transaction is added as income or expense.

### 🏷️ Categories

Transactions can be organized into categories such as:

* Food
* Rent
* Shopping
* Transport
* Gym
* Bills
* Entertainment
* Health
* Education
* Travel
* Coffee
* Personal
* Subscriptions
* Gifts
* Other

### 👤 Profile

* View profile
* Edit profile
* About Pocket Pal
* Privacy Policy

---

## 🛠️ Tech Stack

| Technology    | Usage                           |
| ------------- | ------------------------------- |
| Flutter       | Application development         |
| Dart          | Programming language            |
| Flutter Bloc  | State management                |
| Cubit         | Business logic/state management |
| Local Storage | Data persistence                |

---

## 🧠 Architecture

The project follows a simple **feature-based architecture**.

```text
lib/
│
├── core/
│   └── shared/
│       ├── bottom_nav/
│       ├── utils/
│       └── widgets/
│
├── features/
│   │
│   ├── home/
│   │   └── screens/
│   │
│   ├── transaction/
│   │   ├── cubit/
│   │   ├── models/
│   │   └── widgets/
│   │
│   └── profile/
│       ├── cubit/
│       ├── models/
│       └── screens/
│
└── main.dart
```

---

## 🎨 Design

### Design Style

* Minimal
* Clean
* Rounded cards
* Simple typography
* Black and white color palette
* Easy-to-use forms

---

## 📸 Screenshots

Screenshots will be added as the application UI is completed.

### Dashboard

> Add dashboard screenshot here.

### Add Transaction

> Add income/expense bottom sheet screenshot here.

### Profile

> Add profile screenshot here.

---

## 🚀 Getting Started

### Prerequisites

Make sure you have:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android/iOS emulator or physical device

### Clone the repository

```bash
git clone https://github.com/your-username/pocket_pal.git
```

### Navigate to the project

```bash
cd pocket_pal
```

### Install dependencies

```bash
flutter pub get
```

### Run the application

```bash
flutter run
```

---

## 📦 Dependencies

Install project dependencies using:

```bash
flutter pub get
```

The main state-management dependency is:

```yaml
flutter_bloc:
```

Additional dependencies may be added as the project develops.

---

## 🗺️ Roadmap

* [x] Dashboard UI
* [x] Income UI
* [x] Expense UI
* [x] Income/Expense transaction bottom sheet
* [x] Category selection
* [x] Date picker
* [x] Profile screen
* [x] Edit profile screen
* [x] About screen
* [x] Privacy Policy screen
* [ ] Local database integration
* [ ] Transaction history
* [ ] Edit transaction
* [ ] Delete transaction
* [ ] Search transactions
* [ ] Filter transactions
* [ ] Monthly spending statistics
* [ ] Category-wise spending charts
* [ ] Monthly budget
* [ ] Spending limits
* [ ] Export transactions
* [ ] Backup and restore
* [ ] Dark mode

---

## 🔐 Privacy

Pocket Pal is designed as a personal money management application.

The initial version is intended to store financial data **locally on the user's device** and does not require a backend server.

---

## 📌 Project Status

**In Development 🚧**

Pocket Pal is being developed as a personal Flutter project with a focus on learning and implementing:

* Flutter
* Cubit / Bloc
* Local storage
* Reusable widgets
* Clean UI
* Feature-based architecture
* State management
* Personal finance tracking

---

## 📄 License

This project is currently intended for personal and educational use.

---


