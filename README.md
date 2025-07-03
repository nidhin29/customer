# CaterCraft - Customer Management System

A comprehensive customer management application built with Flutter for catering services. The app enables efficient management of customer data, service bookings, staff coordination, and feedback collection.

## ✨ Key Features

### 🔑 Multi-User Authentication System
- **Three User Types**: Customer (Type 3), Owner (Type 1), and Staff (Type 2)
- Email and password-based secure user authentication
- Role-based access control and dynamic UI permissions
- Seamless sign-in/sign-up experience for all user types
- User session management with token-based authentication

### 👥 Customer Management (Owner Access)
- Add and manage customer profiles and information
- Edit customer contact details and service preferences
- Track complete customer service history and interactions
- Customer feedback collection and management system
- Direct communication tools with customers

### 📋 Service Management (Owner Access)
- Service booking and scheduling system
- Service tracking and real-time status updates
- Comprehensive service history for each customer
- Service approval and rejection workflows
- Service completion marking and tracking

### 👨‍💼 Staff Management (Owner Access)
- Staff profile management and onboarding process
- Team assignment system (Team A, B, C, D, E)
- Multiple staff roles: Manager, Chef, Designer, Delivery Agent, Catering Boy, Local Worker
- Staff wage management and UPI payment integration
- Performance tracking and team coordination features

### 💰 Earnings & Financial Tracking (Owner Access)
- Comprehensive earnings tracking and management
- Service-based revenue calculation and analytics
- Financial reporting and business intelligence
- Revenue insights and profitability analysis

### 💬 Communication System (All Users)
- Internal messaging system between all user types
- Customer-Owner direct communication channels
- Staff-Owner coordination and team messaging
- Real-time chat functionality with user type identification
- Feedback collection and management system

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

### Customer Lifecycle Management (Multi-User)
- **Owner Perspective**: Complete customer onboarding and profile management
- **Customer Perspective**: Self-service profile management and booking history
- **Staff Perspective**: Customer service delivery and interaction tracking
- **Feedback Loop**: Multi-directional feedback collection between all user types
- **Communication**: Role-based messaging and notification system

### Staff Operations (Owner & Staff Users)
- **Owner Functions**: Staff hiring, team assignment, wage management, performance monitoring
- **Staff Functions**: Service delivery, team coordination, customer interaction
- **Team Management**: 5-team structure (Team A-E) with role-based assignments
- **Role Hierarchy**: 6 staff types with different responsibilities and wage levels
- **Communication**: Internal staff messaging and coordination tools

### Business Intelligence (Owner Access)
- **Earnings Analytics**: Revenue tracking, service profitability, financial insights
- **Service Metrics**: Booking patterns, completion rates, customer satisfaction
- **Staff Performance**: Productivity tracking, team efficiency, wage optimization
- **Customer Insights**: Service preferences, booking history, feedback analysis
- **Operational Reports**: Comprehensive business reporting and analytics dashboard

## 📱 Getting Started

### Prerequisites
- Flutter SDK (>= 3.7.2)
- Dart SDK (>= 3.7.2)
- Android Studio or VS Code with Flutter extensions

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
- Instant updates across the application
- Offline capability with local storage


## 🔐 Security & Data Management

- **Data Encryption**: All data encrypted in transit and at rest
- **Local Storage**: Secure local data persistence with SharedPreferences
- **Error Handling**: Comprehensive error handling with custom failure models

## 👥 User Types & Access Levels

CaterCraft supports three distinct user types with different access levels and functionalities:

### 🏢 Owner (User Type: 1)
**Primary Administrator** - Full system access
- **Service Management**: Add, edit, and manage catering services
- **Staff Management**: Hire staff, assign teams, manage wages and performance
- **Customer Oversight**: View all customer profiles and service history
- **Financial Control**: Access earnings, financial reports, and revenue analytics
- **Booking Management**: View and manage all service bookings
- **Team Coordination**: Assign staff to teams (Team A, B, C, D, E)
- **Staff Roles Management**: Assign roles (Manager, Chef, Designer, Delivery Agent, Catering Boy, Local Worker)

### 👤 Customer (User Type: 3)
**Service Recipients** - Customer-focused access
- **Profile Management**: Edit personal information and contact details
- **Service Booking**: Book catering services and view booking history
- **Communication**: Direct messaging with owners and staff
- **Feedback System**: Provide feedback on completed services
- **Service Tracking**: Track status of current bookings

### 👨‍🍳 Staff (User Type: 2)
**Service Providers** - Operational access
- **Booking Operations**: View assigned bookings and team details
- **Team Communication**: Coordinate with team members and managers
- **Service Updates**: Update service status and progress
- **Performance Tracking**: View assigned tasks and responsibilities
- **Customer Interaction**: Communicate with customers regarding services

## 🔐 Role-Based Access Control

The application implements sophisticated role-based access control where:
- **Authentication**: Each user type has dedicated sign-in/sign-up flows
- **Authorization**: Features are dynamically shown/hidden based on user type
- **Data Security**: Users can only access data relevant to their role
- **Session Management**: Secure token-based session handling for all user types

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

## 👨‍💻 Developer

Developed with ❤️ for CaterCraft

For questions or support, please open an issue on GitHub.

---

**About**: CaterCraft is a comprehensive customer management system built with Flutter, designed specifically for catering services. It features customer data management, service booking, staff coordination