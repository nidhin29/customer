# CaterCraft - Customer Management System

A comprehensive customer management application built with Flutter for catering services. The app enables efficient management of customer data, service bookings, staff coordination, and feedback collection with real-time synchronization using Firebase.

## ✨ Key Features

### 🔑 Authentication
- Email and password-based user authentication
- Seamless sign-in/sign-up experience
- User session management

### 👥 Customer Management
- Add and manage customer profiles
- Edit customer information and contact details
- Track customer service history
- Customer feedback collection and management

### � Service Management
- Service booking and scheduling
- Service tracking and status updates
- Service history for each customer
- Real-time service updates

### 👨‍� Staff Management
- Staff profile management
- Staff assignment to services
- Staff performance tracking
- Team coordination features

### 💰 Earnings & Financial Tracking
- Earnings tracking and management
- Service-based revenue calculation
- Financial reporting capabilities

### � Communication System
- Internal messaging system
- Customer communication tools
- Feedback management
- Real-time notifications

## 🏗️ Architecture & Tech Stack

### 📱 Flutter Framework
- Cross-platform mobile app development
- Material Design UI components with Google Fonts
- State management using BLoC/Cubit pattern
- Dependency injection with GetIt and Injectable

### 🧠 Clean Architecture Implementation
```
lib/
├── Application/                    # Business Logic Layer (BLoCs & Cubits)
│   ├── edit_profile/               # Profile editing business logic
│   ├── Feedback/                   # Customer feedback management
│   ├── loggedin/                   # User session management
│   ├── message/                    # Internal messaging system
│   ├── profile/                    # Profile management logic
│   ├── Service/                    # Service booking and tracking
│   ├── signin/                     # User authentication
│   ├── signup/                     # User registration
│   ├── Staff/                      # Staff management logic
│   └── staffview/                  # Staff view and operations
│
├── Core/
│   └── Injectable/                 # Dependency injection configuration
│
├── Domain/                         # Business Models & Interfaces
│   ├── approve/                    # Approval workflow models
│   ├── bookings/                   # Booking management models
│   ├── earn/                       # Earnings and revenue models
│   ├── Failure/                    # Error handling and failures
│   ├── feedback/                   # Customer feedback models
│   ├── LoggedIn/                   # User session models
│   ├── Message/                    # Messaging system models
│   ├── Profile/                    # User profile models
│   ├── Service/                    # Service management models
│   ├── SignIn/                     # Authentication models
│   ├── signout/                    # Sign-out functionality
│   ├── SignUp/                     # Registration models
│   ├── Staff/                      # Staff management models
│   ├── Team/                       # Team coordination models
│   └── TokenManager/               # Authentication token management
│
├── Infrastructure/                 # Data Layer & External Services
│   └── ...                        # Repository implementations
│
├── Presentation/                   # UI Layer
│   ├── Auth/                       # Authentication screens
│   ├── Common/                     # Shared UI components
│   ├── Earnings/                   # Earnings and financial screens
│   ├── Feedback/                   # Feedback management UI
│   ├── Home/                       # Main dashboard and navigation
│   └── Profile/                    # Profile management screens
│
├── constants/                      # App constants and configuration
│   └── const.dart
│
└── main.dart                       # App entry point (CaterCraft)
```

## 🔧 Key Technologies

### State Management:
- **BLoC/Cubit pattern** for predictable state management
- **Flutter BLoC library** for reactive programming
- **GetIt** for dependency injection service locator
- **Injectable** for code generation and DI setup

### Backend & Data:
- **Firebase Authentication** for secure user management
- **Cloud Firestore** for real-time data synchronization
- **Shared Preferences** for local data persistence
- **Dio** for HTTP networking and API calls

### UI & User Experience:
- **Material Design** components and theming
- **Google Fonts** for custom typography
- **Shimmer** effects for loading states
- **Emoji Picker** for enhanced messaging
- **Image & File Picker** for media handling

### Functional Programming:
- **Dartz** for functional programming paradigms
- **Freezed** for immutable data classes
- **Error handling** with Either types and custom failure models

## 📱 Core Functionalities

### Customer Lifecycle Management
- **Profile Creation**: Complete customer onboarding
- **Service History**: Track all customer interactions
- **Feedback Loop**: Collect and manage customer feedback
- **Communication**: Direct messaging with customers

### Staff Operations
- **Staff Coordination**: Manage team assignments
- **Performance Tracking**: Monitor staff productivity
- **Service Assignment**: Allocate staff to specific services
- **Team Communication**: Internal messaging system

### Business Intelligence
- **Earnings Analytics**: Track revenue and profitability
- **Service Metrics**: Monitor service performance
- **Customer Insights**: Analyze customer behavior
- **Operational Reports**: Generate business reports

### Queue Implementation Logic
- Customer data is created locally and added to an in-memory queue
- The queue processes data sequentially in the background, attempting to upload each entry to Firebase
- If an upload fails (e.g., due to connectivity issues), the data is re-queued and retried after a fixed delay
- A StreamController notifies listeners of any queue updates
- The BLoC merges local queued data and remote Firebase data into a single list, ensuring the UI is always up to date

## 📱 Getting Started

### Prerequisites
- Flutter SDK (>= 3.7.2)
- Dart SDK (>= 3.7.2)
- Android Studio or VS Code with Flutter extensions
- Firebase account for backend services

### Installation

#### 1. Clone the repository
```bash
git clone <repository-url>
cd customer
```

#### 2. Install dependencies
```bash
flutter pub get
```

#### 3. Generate dependency injection
```bash
flutter packages pub run build_runner build
```

#### 4. Firebase Setup
- Create a new Firebase project
- Enable Authentication and Firestore
- Download and configure `google-services.json` for Android
- Update Firebase configuration in your project

#### 5. Run the application
```bash
flutter run
```

## 💡 User Experience

### Intuitive Design
- Clean, modern Material Design interface
- Consistent navigation patterns
- Responsive layouts for different screen sizes
- Loading states with shimmer effects

### Real-time Operations
- Live data synchronization with Firebase
- Instant updates across the application
- Offline capability with local storage
- Queue-based data management for reliability

## 🔐 Security & Data Management

- **Firebase Authentication**: Secure user authentication and session management
- **Data Encryption**: All data encrypted in transit and at rest
- **Local Storage**: Secure local data persistence with SharedPreferences
- **Error Handling**: Comprehensive error handling with custom failure models

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 🔮 Future Roadmap

- **Advanced Analytics**: Enhanced reporting and insights dashboard
- **Push Notifications**: Real-time notifications for important events
- **Multi-language Support**: Internationalization for global reach
- **API Integration**: Third-party service integrations
- **Mobile & Web**: Expand to web platform
- **Advanced Search**: Enhanced search and filtering capabilities

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Developer

Developed with ❤️ for CaterCraft

For questions or support, please open an issue on GitHub.

---

**About**: CaterCraft is a comprehensive customer management system built with Flutter, designed specifically for catering services. It features customer data management, service booking, staff coordination, and real-time synchronization with Firebase using a custom async queue system.
