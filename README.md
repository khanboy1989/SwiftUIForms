# 📌 SwiftUIForms - Registration Form with Scalable Validation

## 📝 Overview  
SwiftUIForms is a powerful yet lightweight **SwiftUI-based** registration form that features **real-time input validation** using a **Protocol-Oriented and MVVM architecture**. This project demonstrates how to efficiently handle user input, apply dynamic validation rules, and manage form state in a **scalable and reusable** way.  

---

## 🚀 Features  
- ✅ **SwiftUI `Form` & `Section` Layout** for a clean and structured UI.  
- ✅ **MVVM Architecture** to ensure separation of concerns.  
- ✅ **Protocol-Oriented Validation System** for modular validation rules.  
- ✅ **`ValidatedField` Observable Object** for dynamic input validation.  
- ✅ **Custom `.validatedField` Modifier** for reusable form validation.  
- ✅ **Real-Time Validation** with **debounce** and error handling.  
- ✅ **Auto-Focus Navigation** between fields for better UX.  
- ✅ **Submit Button Disabled Until All Fields Are Valid**.  

---

## 🛠️ Old vs New Validation Implementation  

### 🛡️ Old Approach (Static Validation Methods in a Struct)  
- Used **static functions** inside a `ValidationRules` struct.  
- Validation logic was **tightly coupled** with UI updates.  
- **Difficult to scale** when adding new validation rules.  

```swift
struct ValidationRules {
    static func validateEmail(_ email: String) -> String? {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) ? nil : "Invalid email format"
    }

    static func validatePassword(_ password: String) -> String? {
        return password.count >= 6 ? nil : "Password must be at least 6 characters"
    }
}
```

### ✅ New Approach (Protocol-Oriented Validation with `ValidatedField`)  
- **Uses protocols (`ValidationRule`)** for modular, reusable validation.  
- **Supports multiple validation rules** per field dynamically.  
- **Real-time validation** with `ValidatedField`, avoiding UI coupling.  

#### 🔹 Step 1: Define a Protocol for Validation Rules  
```swift
protocol ValidationRule {
    associatedtype Input
    func validate(_ input: Input) -> String?
}
```

#### 🔹 Step 2: Implement Validation Rules  
```swift
struct EmailValidationRule: ValidationRule {
    typealias Input = String

    func validate(_ input: String) -> String? {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input) ? nil : "Invalid email format"
    }
}
```

#### 🔹 Step 3: Create `ValidatedField` for Dynamic Validation  
```swift
class ValidatedField: ObservableObject {
    @Published var value: String = ""
    @Published var error: String?
    
    private let validationRules: [AnyValidationRule<String>]
    
    init(validationRules: [AnyValidationRule<String>]) {
        self.validationRules = validationRules
        setupValidation()
    }
    
    private func setupValidation() {
        $value
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                self?.error = self?.validate(newValue)
            }
            .store(in: &cancellables)
    }
    
    private func validate(_ value: String) -> String? {
        for rule in validationRules {
            if let error = rule.validate(value) {
                return error
            }
        }
        return nil
    }
}
```

---

## 📷 Screenshots  
<div align="center">
  <img src="https://github.com/user-attachments/assets/c0b10b96-f5e4-4eb9-95f8-130a14bd618f" width="300" />
  <img src="https://github.com/user-attachments/assets/475242be-80ca-47ff-90b4-ea255cef8f61" width="300" />
  <img src="https://github.com/user-attachments/assets/3183df0b-afb6-4a6b-b200-6a43d0e75d05" width="300" />
</div>

---

## 🔧 Installation  
### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/khanboy1989/SwiftUIForms.git
```

### 2️⃣ Open the Project in Xcode  
```bash
cd SwiftUIForms
open SwiftUIForms.xcodeproj
```

### 3️⃣ Run the App  
- Select an **iPhone simulator** or **real device** in Xcode.  
- Click **Run (`Cmd + R`)** to start the app.  

---

